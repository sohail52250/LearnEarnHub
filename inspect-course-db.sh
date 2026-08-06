#!/data/data/com.termux/files/usr/bin/bash

echo "Checking API database routes..."

grep -R "course_catalog" . \
--exclude-dir=node_modules \
--exclude-dir=.git \
--exclude="*.log" | head -30

echo ""
echo "Checking Supabase SQL files..."

find . -name "*.sql" -maxdepth 3

echo ""
echo "Done"
