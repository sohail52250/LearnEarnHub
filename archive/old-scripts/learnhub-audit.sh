#!/data/data/com.termux/files/usr/bin/bash

echo "================================="
echo " LearnEarnHub Platform Audit"
echo "================================="

echo ""
echo "1. Project Structure"
echo "--------------------------------"
find . -maxdepth 2 -type d | sed 's#^\./##' | sort | head -100

echo ""
echo "2. JavaScript Files"
echo "--------------------------------"
find . -name "*.js" | wc -l

echo ""
echo "3. HTML Pages"
echo "--------------------------------"
find . -name "*.html" | wc -l

echo ""
echo "4. Backup / Old Files"
echo "--------------------------------"
find . \( -name "*before*" -o -name "*backup*" -o -name "*old*" \)

echo ""
echo "5. Database References"
echo "--------------------------------"
grep -R "supabase\|database\|createClient" . --include="*.js" | head -100

echo ""
echo "6. Feature Tables Used"
echo "--------------------------------"
grep -R "from(" . --include="*.js" | sort -u

echo ""
echo "7. Undefined Values"
echo "--------------------------------"
grep -R "undefined" public pages . --include="*.html" --include="*.js" | head -50

echo ""
echo "8. Translation Files"
echo "--------------------------------"
find . -iname "*lang*" -o -iname "*locale*" -o -iname "*translation*"

echo ""
echo "9. Security Check"
echo "--------------------------------"
grep -R "password\|secret\|apikey\|service_role" . --include="*.js" | head -50

echo ""
echo "================================="
echo " Audit Completed"
echo "================================="
