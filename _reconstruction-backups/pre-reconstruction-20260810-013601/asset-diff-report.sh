#!/data/data/com.termux/files/usr/bin/bash

echo "===== Asset Difference Report ====="

for pair in \
"public/supabase-config.js public/js/supabase-config.js" \
"public/role-guard.js public/js/role-guard.js" \
"public/lesson-progress.js public/js/lesson-progress.js" \
"public/enrollment.js public/js/enrollment.js" \
"public/components/leh-design-system.css public/assets/css/leh-design-system.css"

do

set -- $pair

echo
echo "================================"
echo "$1 VS $2"
echo "================================"

diff -u $1 $2 | head -80

done

echo
echo "===== DONE ====="

