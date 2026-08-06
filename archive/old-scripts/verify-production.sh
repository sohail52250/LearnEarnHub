#!/data/data/com.termux/files/usr/bin/bash

BASE="https://learn-earnhub.vercel.app"

echo "=================================="
echo "LearnEarnHub Production Audit"
echo "=================================="

for page in \
index.html \
login.html \
student-dashboard.html \
business-dashboard.html \
admin-control-dashboard.html \
admin-ai-deal-room.html \
market.html \
post-ad.html \
about.html \
courses.html
do
printf "%-40s" "$page"
curl -s -o /dev/null -w "%{http_code}\n" "$BASE/$page"
done

echo ""
echo "API"

for api in \
api/status \
api/ai-deal-test
do
printf "%-40s" "$api"
curl -s -o /dev/null -w "%{http_code}\n" "$BASE/$api"
done

echo ""
echo "Done"
