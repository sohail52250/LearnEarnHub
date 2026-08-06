#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub || exit 1

COMMIT=$(cat safe-backups/stable-july29-2026/commit.txt)

echo "=================================="
echo "LearnEarnHub Stable Restore"
echo "=================================="
echo "Commit: $COMMIT"

git fetch origin
git reset --hard "$COMMIT"

echo "Deploying..."
vercel --prod

echo "=================================="
echo "Restore Complete"
echo "=================================="
