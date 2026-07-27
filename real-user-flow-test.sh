#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app"

echo "======================================"
echo " LearnEarnHub REAL USER FLOW TEST"
echo "======================================"

EMAIL="realtest$(date +%s)@example.com"
PASSWORD="Test12345"
NAME="Real Flow Tester"
PHONE="03000000000"

echo ""
echo "1) REGISTER USER"

REGISTER=$(curl -s -X POST "$URL/api/auth" \
-H "Content-Type: application/json" \
-d "{\"action\":\"register\",\"name\":\"$NAME\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\",\"phone\":\"$PHONE\"}")

echo "$REGISTER" | tee real-register.json

USER_ID=$(echo "$REGISTER" | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4)

echo ""
echo "USER ID:"
echo "$USER_ID"


echo ""
echo "2) LOGIN USER"

LOGIN=$(curl -s -X POST "$URL/api/auth" \
-H "Content-Type: application/json" \
-d "{\"action\":\"login\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")

echo "$LOGIN" | tee real-login.json


echo ""
echo "3) GET COURSE"

COURSES=$(curl -s "$URL/api/courses")

echo "$COURSES" | tee real-courses.json

COURSE_ID=$(echo "$COURSES" | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4)

echo ""
echo "COURSE ID:"
echo "$COURSE_ID"


echo ""
echo "4) COMPLETE COURSE"

COMPLETE=$(curl -s -X POST "$URL/api/complete-course" \
-H "Content-Type: application/json" \
-d "{\"user_id\":\"$USER_ID\",\"course_id\":\"$COURSE_ID\"}")

echo "$COMPLETE" | tee real-complete-course.json


echo ""
echo "5) DASHBOARD CHECK"

DASH=$(curl -s "$URL/api/dashboard?user_id=$USER_ID")

echo "$DASH" | tee real-dashboard.json


echo ""
echo "6) USER CHECK"

curl -s "$URL/api/users" | tee real-users.json


echo ""
echo "======================================"
echo " TEST FINISHED"
echo " Reports:"
echo " real-register.json"
echo " real-login.json"
echo " real-courses.json"
echo " real-complete-course.json"
echo " real-dashboard.json"
echo "======================================"

