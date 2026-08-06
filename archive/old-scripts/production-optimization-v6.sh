#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Production Optimization V6"
echo "======================================"

mkdir -p reports backups


echo "1) Creating project inventory..."

find public -type f > reports/public-files.txt
find api -type f > reports/api-files.txt
find database -type f > reports/database-files.txt


echo "2) Creating backup snapshot..."

tar -czf backups/learnehub-backup-$(date +%Y%m%d-%H%M%S).tar.gz \
api public database package.json 2>/dev/null || true


echo "3) Checking package..."

if [ -f package.json ]; then
cat package.json > reports/package-report.txt
fi


echo "4) Checking large files..."

find . -type f -size +500k > reports/large-files.txt


echo "5) Creating performance notes..."

cat > reports/performance-plan.txt <<TXT

LearnEarnHub Optimization Plan

1. Enable API response caching where suitable.
2. Compress static assets.
3. Remove unused duplicate SQL files after migration backup.
4. Add database indexes for frequently searched tables.
5. Optimize images and frontend assets.
6. Monitor Vercel function execution time.

TXT


git add .

git commit -m "Add production optimization audit and backup system" || true

git push


echo "======================================"
echo " Optimization V6 Completed"
echo "======================================"

