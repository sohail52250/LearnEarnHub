#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Final Production Check ====="

echo
echo "=== Git Status ==="
git status

echo
echo "=== Duplicate Asset Check ==="

for f in supabase-config.js role-guard.js lesson-progress.js enrollment.js leh-design-system.css
do
echo "--- $f ---"
find public -name "$f"
done

echo
echo "=== Broken Old References ==="

grep -R "/supabase-config.js" public --include="*.html"
grep -R "/role-guard.js" public --include="*.html"
grep -R "/lesson-progress.js" public --include="*.html"
grep -R "/enrollment.js" public --include="*.html"

echo
echo "=== Design System Usage ==="

grep -Rl "leh-design-system.css" public --include="*.html" | wc -l

echo
echo "=== Production Website ==="

curl -I -s https://learn-earnhub.vercel.app | head -5

echo
echo "=== API ==="

curl -s https://learn-earnhub.vercel.app/api/status

echo
echo "===== COMPLETE ====="
