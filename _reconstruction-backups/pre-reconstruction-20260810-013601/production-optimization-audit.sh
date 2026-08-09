#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Production Optimization Audit ====="

echo
echo "=== Repository Status ==="
git status

echo
echo "=== File Counts ==="
echo "HTML:"
find public -name "*.html" | wc -l

echo "CSS:"
find public -name "*.css" | wc -l

echo "JS:"
find public -name "*.js" | wc -l

echo
echo "=== Large Files (>500KB) ==="
find public -type f -size +500k

echo
echo "=== Duplicate CSS Names ==="
find public -name "*.css" -printf "%f\n" | sort | uniq -d

echo
echo "=== Duplicate JS Names ==="
find public -name "*.js" -printf "%f\n" | sort | uniq -d

echo
echo "=== Unused Style References Check ==="
grep -R "href=.*css" public --include="*.html" | wc -l

echo
echo "=== Unused Script References Check ==="
grep -R "<script" public --include="*.html" | wc -l

echo
echo "=== Vercel Production ==="
curl -I -s https://learn-earnhub.vercel.app | head -5

echo
echo "=== API Health ==="
curl -s https://learn-earnhub.vercel.app/api/status

echo
echo "===== Audit Complete ====="

