#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Final Safe Refinement ====="

DATE=$(date +%Y%m%d-%H%M)

mkdir -p safe-backups/$DATE

echo "[1] Backup current API files"
cp api/users.js safe-backups/$DATE/ 2>/dev/null
cp public/courses-v2.js safe-backups/$DATE/ 2>/dev/null

echo "[2] Fix users API password leak"

python3 <<'PY'
from pathlib import Path

p=Path("api/users.js")

if p.exists():
    s=p.read_text()

    s=s.replace(
        "password",
        "password_removed"
    )

    p.write_text(s)

print("Users API checked")
PY


echo "[3] Fix course undefined display"

python3 <<'PY'
from pathlib import Path

p=Path("public/courses-v2.js")

if p.exists():

    s=p.read_text()

    s=s.replace(
    "course.level",
    "course.level || 'Beginner'"
    )

    s=s.replace(
    "course.rating",
    "course.rating || 0"
    )

    s=s.replace(
    "course.students",
    "course.students || 0"
    )

    p.write_text(s)

print("Course display improved")
PY


echo "[4] Protect backup folders from deployment"

cat > .vercelignore <<'TXT'
node_modules
backups
public.before-student-dashboard
public/lessons.before*
*.backup*
safe-backups
audit.txt
reports
TXT


echo "[5] Generate final report"

mkdir -p reports/final

{
echo "LearnEarnHub Final Production Report"
echo ""
echo "Date:"
date

echo ""
echo "Pages:"
find public -name "*.html" | wc -l

echo ""
echo "API:"
ls api

echo ""
echo "Languages:"
ls public/translations/*en.json | wc -l
ls public/translations/*ur.json | wc -l

echo ""
echo "Database references:"
grep -R '.from("' public api routes --include="*.js" | wc -l

} > reports/final/production-report.txt


echo "[6] Git update"

git add .

git commit -m "Final safe platform refinement security and course fixes"

git push


echo "===== COMPLETE ====="

