#!/data/data/com.termux/files/usr/bin/bash

echo "=== Checking learning API usage ==="

grep -R "\.from(" public \
--include="*.js" \
| grep -E "course|lesson|progress|enroll" \
| sort -u

echo ""
echo "=== Checking SQL table names ==="

grep -R "CREATE TABLE" database supabase \
--include="*.sql" \
| grep -E "course|lesson|progress|enroll" \
| sort -u

echo ""
echo "=== Done ==="
