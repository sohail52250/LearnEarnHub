#!/data/data/com.termux/files/usr/bin/bash

echo "=== Checking Computer Fundamentals references ==="

grep -R "Computer Fundamentals\|course_id.*176\|176" public \
--include="*.js" \
--include="*.html" \
| head -50

echo ""
echo "=== Checking deployment ==="

curl -s https://learn-earnhub.vercel.app/api/status

echo ""
echo "DONE"
