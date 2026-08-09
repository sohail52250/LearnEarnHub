#!/data/data/com.termux/files/usr/bin/bash

echo "Fixing LearnEarnHub script paths..."

find public -type f -name "*.html" -exec sed -i \
's#/js/js/role-guard.js#/js/role-guard.js#g;
s#/js/js/lesson-progress.js#/js/lesson-progress.js#g;
s#/js/js/supabase-config.js#/js/supabase-config.js#g' {} \;

echo "Checking remaining bad paths..."

grep -R "/js/js/" public --include="*.html" || echo "No broken /js/js paths found"

echo "Done"
