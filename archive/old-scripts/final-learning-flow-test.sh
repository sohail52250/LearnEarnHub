#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app"

echo "===== FINAL LEARNING FLOW TEST ====="

echo ""
echo "STATUS:"
curl -s $URL/api/status

echo ""
echo ""
echo "COURSES:"
curl -s $URL/api/courses

echo ""
echo ""
echo "COURSE PLAYER:"
curl -I -s $URL/course-player.html | head -1

echo ""
echo ""
echo "DASHBOARD:"
curl -s "$URL/api/dashboard?user_id=3ddc5d80-b236-43d4-ace5-d8ff4e7a6c47"

echo ""
echo ""
echo "PAGES:"

for page in \
index.html \
courses.html \
course-player.html \
learner-dashboard.html \
course-marketplace.html \
business-marketplace.html

do
echo -n "$page : "
curl -o /dev/null -s -w "%{http_code}\n" $URL/$page
done

echo ""
echo "===== COMPLETE ====="

