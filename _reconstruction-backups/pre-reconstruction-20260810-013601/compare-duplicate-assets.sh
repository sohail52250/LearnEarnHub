#!/data/data/com.termux/files/usr/bin/bash

echo "===== Duplicate File Comparison ====="

for pair in \
"public/supabase-config.js public/js/supabase-config.js" \
"public/role-guard.js public/js/role-guard.js" \
"public/lesson-progress.js public/js/lesson-progress.js" \
"public/enrollment.js public/js/enrollment.js" \
"public/components/leh-design-system.css public/assets/css/leh-design-system.css"

do
echo
echo "=== Comparing ==="
echo "$pair"

set -- $pair

echo "--- Size ---"
wc -c $1 $2

echo "--- MD5 ---"
md5sum $1 $2

done

echo
echo "===== Complete ====="
