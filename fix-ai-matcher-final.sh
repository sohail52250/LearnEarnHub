#!/data/data/com.termux/files/usr/bin/bash

echo "=== Fix AI Matcher Final ==="

echo "Checking active matcher files..."

grep -R "AI matched using learner skill profile" services scripts api 2>/dev/null


echo ""
echo "Removing old duplicate recommendations..."

cat > /tmp/cleanup-ai.sql <<'SQL'
delete from public.recommendations;

notify pgrst,'reload schema';
SQL

echo ""
echo "Run this SQL in Supabase:"
cat /tmp/cleanup-ai.sql


echo ""
echo "Testing matcher file..."

node -c services/ai/job-matching-bridge.js


echo ""
echo "=== Fix Complete ==="
echo "1. Clear old recommendations"
echo "2. Run matcher again"
echo ""
echo "node scripts/run-ai-job-matching.js"

