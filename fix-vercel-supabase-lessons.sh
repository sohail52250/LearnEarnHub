#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "===== LearnEarnHub Supabase Auto Fix ====="

echo ""
echo "1) Checking local Supabase variables"

if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_KEY" ]; then
    echo "Missing SUPABASE_URL or SUPABASE_KEY in current shell"
    echo "Loading from .env if available..."

    if [ -f .env ]; then
        export $(grep -v '^#' .env | xargs)
    fi
fi


if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_KEY" ]; then
    echo "ERROR: Supabase variables not found"
    exit 1
fi


echo "Supabase URL found:"
echo "$SUPABASE_URL"


echo ""
echo "2) Checking local lesson database"

LOCAL=$(psql "$SUPA_DB" -t -c "select count(*) from course_lessons;" | tr -d ' ')

echo "Local lessons: $LOCAL"


if [ "$LOCAL" -lt 1 ]; then
    echo "ERROR: Local database has no lessons"
    exit 1
fi


echo ""
echo "3) Updating Vercel environment"

vercel env rm SUPABASE_URL production -y || true
vercel env rm SUPABASE_KEY production -y || true


echo "$SUPABASE_URL" | vercel env add SUPABASE_URL production

echo "$SUPABASE_KEY" | vercel env add SUPABASE_KEY production


echo ""
echo "4) Deploying"

vercel --prod --force


echo ""
echo "Waiting..."
sleep 15


echo ""
echo "5) Testing debug API"

DEBUG=$(curl -s https://learn-earnhub.vercel.app/api/debug-lessons)

echo "$DEBUG"


echo ""
echo "6) Testing lesson API"

RESULT=$(curl -s https://learn-earnhub.vercel.app/api/courses/lessons/1)

echo "$RESULT" | head -c 300

COUNT=$(echo "$RESULT" | jq length 2>/dev/null || echo 0)


echo ""

if [ "$COUNT" -gt 0 ]; then
    echo "================================="
    echo "SUCCESS: Lessons API is working"
    echo "Lessons returned: $COUNT"
    echo "================================="
else
    echo "================================="
    echo "FAILED: Still no lessons"
    echo "================================="
fi
