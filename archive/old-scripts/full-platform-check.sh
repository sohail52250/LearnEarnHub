#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app"

echo "================================="
echo " LearnEarnHub Full Platform Check"
echo "================================="

mkdir -p reports/live-test

REPORT="reports/live-test/full-platform-report.txt"

echo "LearnEarnHub Production Report" > $REPORT
echo "Date: $(date)" >> $REPORT
echo "" >> $REPORT


check_api(){

echo "===== $1 =====" | tee -a $REPORT

RESULT=$(curl -s "$URL$2")

echo "$RESULT" | tee -a $REPORT

echo "" >> $REPORT
}


echo "Checking Homepage..."
curl -I $URL >> $REPORT 2>&1


check_api "STATUS API" "/api/status"
check_api "COURSES API" "/api/courses"
check_api "USERS API" "/api/users"
check_api "AUTH API" "/api/auth"
check_api "ADS API" "/api/ads"
check_api "COURSE COMPLETE API" "/api/complete-course"
check_api "DASHBOARD API" "/api/dashboard"


echo "===== PAGE CHECK =====" >> $REPORT

for page in \
index.html \
courses.html \
course-marketplace.html \
learner-dashboard.html \
business-marketplace.html \
matched-opportunities.html \
register-v2.html \
instructors.html
do

echo "Checking $page" >> $REPORT

CODE=$(curl -o /dev/null -s -w "%{http_code}" "$URL/$page")

echo "$page : HTTP $CODE" >> $REPORT

done


echo "" >> $REPORT
echo "===== LANGUAGE CHECK =====" >> $REPORT

ls public/translations/*-en.json >> $REPORT
ls public/translations/*-ur.json >> $REPORT


echo "" >> $REPORT
echo "===== DATABASE USAGE FILES =====" >> $REPORT

ls database* *.sql 2>/dev/null >> $REPORT


echo "" >> $REPORT
echo "===== JAVASCRIPT SUPABASE TABLE USAGE =====" >> $REPORT

grep -R ".from(" public routes api \
--include="*.js" \
| grep -v node_modules \
>> $REPORT


echo "" >> $REPORT
echo "===== GIT STATUS =====" >> $REPORT

git status >> $REPORT


echo ""
echo "================================="
echo "REPORT CREATED:"
echo "$REPORT"
echo "================================="


git add reports/live-test/full-platform-report.txt

git commit -m "Add LearnEarnHub full production health report"

git push


echo "DONE"
