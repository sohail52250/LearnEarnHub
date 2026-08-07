#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Final UI Audit ====="

echo
echo "=== Git ==="
git status

echo
echo "=== HTML Count ==="
find public -name "*.html" | wc -l

echo
echo "=== CSS Count ==="
find public -name "*.css" | wc -l

echo
echo "=== Inline Style Count ==="
grep -R 'style="' public --include="*.html" | wc -l

echo
echo "=== Button Count ==="
grep -R "<button" public --include="*.html" | wc -l

echo
echo "=== Design System Usage ==="
grep -R "leh-design-system.css" public --include="*.html" | wc -l

echo
echo "=== Missing Assets Check ==="
find public -type f | grep -E "\.(png|jpg|jpeg|svg|webp)$" | wc -l

echo
echo "=== Vercel ==="
curl -I -s https://learn-earnhub.vercel.app | head -5

echo
echo "=== API ==="
curl -s https://learn-earnhub.vercel.app/api/status

echo
echo "===== COMPLETE ====="

