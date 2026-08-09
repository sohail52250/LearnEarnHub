#!/data/data/com.termux/files/usr/bin/bash

echo "===== Duplicate Asset Analysis ====="

for f in leh-design-system.css enrollment.js lesson-progress.js role-guard.js supabase-config.js
do
 echo
 echo "=== $f ==="
 find public -name "$f"
done

echo
echo "=== Supabase Config Usage ==="
grep -Rl "supabase-config.js" public --include="*.html" | wc -l

echo
echo "=== Role Guard Usage ==="
grep -Rl "role-guard.js" public --include="*.html" | wc -l

echo
echo "=== Lesson Progress Usage ==="
grep -Rl "lesson-progress.js" public --include="*.html" | wc -l

echo
echo "===== Complete ====="
