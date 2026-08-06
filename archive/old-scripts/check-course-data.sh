#!/data/data/com.termux/files/usr/bin/bash

echo "===== COURSE RECORD ====="

curl -s https://learn-earnhub.vercel.app/api/courses | python3 -m json.tool

echo ""
echo "===== COURSE FILES ====="

ls public/lessons

