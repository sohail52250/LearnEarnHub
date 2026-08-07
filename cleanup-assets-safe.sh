#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Safe Asset Cleanup ====="

mkdir -p backup-old-assets

echo "Moving old duplicate assets..."

mv public/supabase-config.js backup-old-assets/ 2>/dev/null
mv public/role-guard.js backup-old-assets/ 2>/dev/null
mv public/lesson-progress.js backup-old-assets/ 2>/dev/null
mv public/enrollment.js backup-old-assets/ 2>/dev/null
mv public/components/leh-design-system.css backup-old-assets/ 2>/dev/null

echo "Updating references..."

grep -Rl "supabase-config.js" public --include="*.html" | xargs sed -i 's|/supabase-config.js|/js/supabase-config.js|g'

grep -Rl "role-guard.js" public --include="*.html" | xargs sed -i 's|/role-guard.js|/js/role-guard.js|g'

grep -Rl "lesson-progress.js" public --include="*.html" | xargs sed -i 's|/lesson-progress.js|/js/lesson-progress.js|g'

grep -Rl "enrollment.js" public --include="*.html" | xargs sed -i 's|/enrollment.js|/js/enrollment.js|g'

echo "Checking..."

find public -name "supabase-config.js"
find public -name "role-guard.js"
find public -name "lesson-progress.js"
find public -name "enrollment.js"

echo "===== Cleanup Complete ====="

