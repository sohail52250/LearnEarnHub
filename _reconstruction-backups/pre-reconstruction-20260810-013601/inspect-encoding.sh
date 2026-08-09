#!/data/data/com.termux/files/usr/bin/bash

echo "=== Checking charset declarations ==="

grep -R "<meta charset" public \
--include="*.html" | head -50

echo
echo "=== Checking language json encoding ==="

file public/translations/*.json | head -20

echo
echo "=== Checking Vercel headers ==="

cat vercel.json

echo
echo "DONE"
