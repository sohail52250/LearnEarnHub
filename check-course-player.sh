#!/data/data/com.termux/files/usr/bin/bash

echo "=== Lesson API references ==="
grep -Rni "api/courses/lessons" public/ || echo "NOT FOUND"

echo
echo "=== Fetch calls ==="
grep -Rni "fetch(" public/course-player.js || echo "NO FETCH FOUND"

echo
echo "=== Course player file size ==="
wc -l public/course-player.js

echo
echo "=== First 250 lines ==="
sed -n '1,250p' public/course-player.js
