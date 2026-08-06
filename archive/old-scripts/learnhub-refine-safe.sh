#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 LearnEarnHub Safe Refinement Started"

DATE=$(date +"%Y%m%d-%H%M")
REPORT="refine-report-$DATE"

mkdir -p "$REPORT"

echo "📁 Creating backup of files before changes..."
mkdir -p "$REPORT/pre-change"

cp public/course-loader.js "$REPORT/pre-change/" 2>/dev/null
cp public/course-marketplace.js "$REPORT/pre-change/" 2>/dev/null
cp public/courses-v2.js "$REPORT/pre-change/" 2>/dev/null

echo "1) Scanning backup folders..."
find . -type d \( -name "*before*" -o -name "*backup*" -o -name "*old*" \) \
> "$REPORT/backup-folders.txt"


echo "2) Scanning database tables usage..."
grep -R "\.from(" public routes api --include="*.js" \
> "$REPORT/database-usage.txt"


echo "3) Scanning languages..."
find public/translations -type f \
> "$REPORT/languages.txt"


echo "4) Scanning undefined problems..."
grep -R "undefined" public routes api \
--include="*.js" --include="*.html" \
> "$REPORT/undefined.txt"


echo "5) Creating page map..."
find public -type f \
> "$REPORT/pages.txt"


echo "6) Creating course system map..."
grep -R "courses\|course_catalog\|instructor_courses" \
public routes api \
--include="*.js" \
> "$REPORT/course-system.txt"


echo "7) Fixing common undefined course display..."

FILES="
public/course-loader.js
public/course-marketplace.js
public/courses-v2.js
"

for FILE in $FILES
do

if [ -f "$FILE" ]; then

sed -i \
's/${course.level}/${course.level || "Beginner"}/g' \
"$FILE"

sed -i \
's/${course.instructor}/${course.instructor || "LearnEarnHub Instructor"}/g' \
"$FILE"

sed -i \
's/${course.rating}/${course.rating || "New"}/g' \
"$FILE"

sed -i \
's/${course.students}/${course.students || 0}/g' \
"$FILE"

echo "Updated $FILE"

fi

done


echo "8) Creating platform status file..."

cat > public/platform-status.json <<JSON
{
"name":"LearnEarnHub",
"type":"Learning Employment Business Network",
"modules":[
"Courses",
"Instructors",
"Learners",
"Certificates",
"Badges",
"Opportunities",
"Applications",
"Business Marketplace",
"Enterprise",
"Translations",
"Admin"
],
"languages":[
"English",
"Urdu",
"Arabic",
"Dutch"
],
"cleanup":"Safe refinement completed",
"deleted":false
}
JSON


echo ""
echo "✅ COMPLETE"
echo "Reports saved in:"
echo "$REPORT"

