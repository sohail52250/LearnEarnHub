#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app"

echo "======================================"
echo " LearnEarnHub Production Audit V5"
echo "======================================"

mkdir -p reports


echo ""
echo "1) PLATFORM STATUS"
curl -s "$URL/api/status"


echo ""
echo ""
echo "2) IMPORTANT PAGES"

for page in \
index.html \
courses.html \
my-courses.html \
learner-dashboard.html \
unified-profile.html \
dashboard-v2.html \
admin-control-center-v3.html \
security-center.html \
enterprise-register.html \
enterprise-training.html \
enterprise-analytics.html \
enterprise-hiring.html \
enterprise-compliance.html

do

code=$(curl -o /dev/null -s -w "%{http_code}" "$URL/$page")

echo "$page : $code"

done



echo ""
echo "3) API CHECK"

for api in \
status \
courses \
notifications \
messages \
security-health \
admin-control-center

do

echo -n "$api : "

curl -o /dev/null -s -w "%{http_code}\n" "$URL/api/$api"

done



echo ""
echo "4) LOCAL GIT CHECK"

git status > reports/git-status.txt

cat reports/git-status.txt



echo ""
echo "5) ENVIRONMENT CHECK"

if [ -f .env ]; then

echo ".env file exists"

else

echo "WARNING: .env file not found"

fi



echo ""
echo "6) SQL INVENTORY"

find . -name "*.sql" > reports/sql-files.txt

wc -l reports/sql-files.txt



echo ""
echo "7) API INVENTORY"

find api -name "*.js" > reports/api-files.txt

wc -l reports/api-files.txt



echo ""
echo "8) AUDIT REPORT"

date > reports/production-audit.txt

echo "Production audit completed" >> reports/production-audit.txt


echo ""
echo "======================================"
echo " Production Audit Complete"
echo " Reports saved in reports/"
echo "======================================"

