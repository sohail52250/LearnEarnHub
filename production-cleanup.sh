#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Production Cleanup ==="

echo "Removing local test backups..."

rm -f api/auth.backup.*
rm -f api/users.backup.*
rm -f *.tar.gz

echo "Checking test files..."

git status

echo ""
echo "Removing generated reports from git tracking..."

git rm -r --cached reports 2>/dev/null || true
git rm --cached audit.txt backup-report.txt courses-report.txt database-usage-report.txt language-report.txt navigation-audit.txt undefined-report.txt 2>/dev/null || true

echo ""
echo "Commit cleanup..."

git add .
git commit -m "Production cleanup remove test backups and reports" || true

git push

echo ""
echo "Final API check"

curl -s https://learn-earnhub.vercel.app/api/status

echo ""
echo "DONE"

