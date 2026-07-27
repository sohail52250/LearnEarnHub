#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Production Cleanup"
echo "======================================"

echo ""
echo "1) Remove local temporary backups"

rm -f api/auth.backup.*
rm -f api/users.backup.*
rm -f *.tar.gz


echo ""
echo "2) Check generated reports"

git status --short


echo ""
echo "3) Remove reports from Git tracking only"

git rm -r --cached reports 2>/dev/null || true

git rm --cached \
audit.txt \
backup-report.txt \
courses-report.txt \
database-usage-report.txt \
language-report.txt \
navigation-audit.txt \
undefined-report.txt \
2>/dev/null || true


echo ""
echo "4) Add remaining changes"

git add .


echo ""
echo "5) Commit"

git commit -m "Production cleanup remove temporary audit files" || true


echo ""
echo "6) Push"

git push


echo ""
echo "7) Live status check"

curl -s https://learn-earnhub.vercel.app/api/status

echo ""
echo ""
echo "8) Live users API check"

curl -s https://learn-earnhub.vercel.app/api/users


echo ""
echo ""
echo "======================================"
echo " CLEANUP COMPLETE"
echo "======================================"

