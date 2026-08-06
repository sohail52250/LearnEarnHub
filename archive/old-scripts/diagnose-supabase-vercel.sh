#!/data/data/com.termux/files/usr/bin/bash

echo "===== DATABASE CHECK ====="

echo ""
echo "Local Supabase URL:"
echo "$SUPABASE_URL"

echo ""
echo "Local lessons:"
psql "$SUPA_DB" -c "
select count(*) as lessons from course_lessons;
"

echo ""
echo "Database.js:"
sed -n '1,120p' database.js

echo ""
echo "Vercel variables:"
vercel env ls

echo ""
echo "Checking Supabase project tables through API"

curl -s \
-H "apikey: $SUPABASE_KEY" \
-H "Authorization: Bearer $SUPABASE_KEY" \
"$SUPABASE_URL/rest/v1/course_lessons?select=id,course_id,title_en&limit=3" | jq

echo ""
echo "===== DONE ====="
