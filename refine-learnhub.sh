#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 LearnEarnHub Refinement Audit"

echo ""
echo "1. Checking undefined course fields..."
grep -R "undefined" public --include="*.js" --include="*.html" > undefined-report.txt

echo "Created undefined-report.txt"

echo ""
echo "2. Checking active database tables usage..."
grep -R "\.from(" public routes api --include="*.js" > database-usage-report.txt

echo "Created database-usage-report.txt"

echo ""
echo "3. Checking backup folders (NOT deleting)..."
find . -type d \( -name "*before*" -o -name "*backup*" -o -name "*old*" \) > backup-report.txt

echo "Created backup-report.txt"

echo ""
echo "4. Checking languages..."
find public/translations -type f > language-report.txt

echo "Created language-report.txt"

echo ""
echo "5. Checking courses..."
grep -R "course_catalog\|instructor_courses\|from(\"courses\")" public routes api --include="*.js" > courses-report.txt

echo "Created courses-report.txt"

echo ""
echo "✅ Refinement audit complete"
