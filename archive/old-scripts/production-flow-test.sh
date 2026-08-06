#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app"

echo "===== LearnEarnHub User Flow Test ====="

echo ""
echo "1. Homepage"
curl -o /dev/null -s -w "Homepage HTTP: %{http_code}\n" $URL/

echo ""
echo "2. Courses"
curl -o /dev/null -s -w "Courses HTTP: %{http_code}\n" $URL/courses.html

echo ""
echo "3. Course API"
curl -s $URL/api/courses

echo ""
echo "4. Authentication API"
curl -s $URL/api/auth

echo ""
echo "5. Dashboard API"
curl -s "$URL/api/dashboard"

echo ""
echo "6. Ads API"
curl -s $URL/api/ads

echo ""
echo "7. Main Pages"

for page in \
register-v2.html \
learner-dashboard.html \
course-marketplace.html \
business-marketplace.html \
matched-opportunities.html \
instructors.html

do
echo -n "$page : "
curl -o /dev/null -s -w "%{http_code}\n" $URL/$page
done

echo ""
echo "===== DATABASE ACTIVE TABLE REFERENCES ====="

grep -R '.from("' public api routes --include="*.js" \
| sed 's/.*from("\([^"]*\).*/\1/' \
| sort -u

echo ""
echo "===== COMPLETE ====="

