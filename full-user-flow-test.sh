#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app"

echo "======================================"
echo " LearnEarnHub Full User Flow Test"
echo "======================================"

echo ""
echo "1) PLATFORM STATUS"
curl -s $URL/api/status


echo ""
echo ""
echo "2) CREATE TEST USER"
EMAIL="flowtest$(date +%s)@example.com"
PASSWORD="Test12345"
PHONE="03000000000"

REGISTER=$(curl -s -X POST $URL/api/auth \
-H "Content-Type: application/json" \
-d "{\"action\":\"register\",\"name\":\"Flow Test User\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\",\"phone\":\"$PHONE\"}")

echo $REGISTER


echo ""
echo ""
echo "3) LOGIN TEST USER"

LOGIN=$(curl -s -X POST $URL/api/auth \
-H "Content-Type: application/json" \
-d "{\"action\":\"login\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")

echo $LOGIN


echo ""
echo ""
echo "4) COURSES CHECK"

curl -s $URL/api/courses


echo ""
echo ""
echo "5) COMPLETE COURSE API CHECK"

curl -s -X POST $URL/api/complete-course \
-H "Content-Type: application/json" \
-d '{"user_id":"TEST_USER_ID","course_id":"TEST_COURSE_ID"}'


echo ""
echo ""
echo "6) ADS SYSTEM CHECK"

curl -s $URL/api/ads


echo ""
echo ""
echo "7) DASHBOARD CHECK"

curl -s "$URL/api/dashboard?user_id=TEST_USER_ID"


echo ""
echo ""
echo "8) IMPORTANT PAGES"

for page in \
index.html \
register-v2.html \
courses.html \
my-courses.html \
learner-dashboard.html \
course-player.html \
business-register.html \
business-marketplace.html \
post-opportunity.html \
apply-opportunity.html \
submit-advertisement.html

do
echo -n "$page : "
curl -o /dev/null -s -w "%{http_code}\n" $URL/$page
done


echo ""
echo ""
echo "9) DATABASE TABLE HEALTH"

grep -R '.from("' public api routes --include="*.js" \
| sed 's/.*from("\([^"]*\).*/\1/' \
| sort -u > flow-active-tables.txt

echo "Active tables saved:"
echo "flow-active-tables.txt"


echo ""
echo "======================================"
echo " FLOW TEST COMPLETE"
echo "======================================"

