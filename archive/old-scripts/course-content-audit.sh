#!/data/data/com.termux/files/usr/bin/bash

echo "===== COURSE DATABASE STRUCTURE ====="

grep -R "content_en\|content_ur\|lesson" database *.sql api public routes --include="*.sql" --include="*.js" | head -100

echo ""
echo "===== COURSE API ====="

sed -n '1,220p' api/courses.js

echo ""
echo "===== COURSE PLAYER ====="

ls -lh public/*course*

