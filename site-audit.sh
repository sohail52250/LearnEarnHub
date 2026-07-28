#!/data/data/com.termux/files/usr/bin/bash

BASE="https://learn-earnhub.vercel.app"

echo "===== MAIN PAGES ====="

for page in \
index.html \
login.html \
student-dashboard.html \
business-dashboard.html \
admin-ai-deal-room.html \
about.html \
courses.html
do
    printf "%-40s" "$page"
    curl -s -o /dev/null -w "%{http_code}\n" "$BASE/$page"
done

echo
echo "===== API ====="

for api in \
api/status \
api/ai-deal-test \
api/admin/ai-deal-requests
do
    printf "%-40s" "$api"
    curl -s -o /dev/null -w "%{http_code}\n" "$BASE/$api"
done

echo
echo "===== SEARCHING HTML FILES ====="

find public -maxdepth 1 -name "*.html" | wc -l

echo
echo "===== VERIFY FILES TRACKED BY GIT ====="

git ls-files public | wc -l

echo
echo "===== DONE ====="
