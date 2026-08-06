#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub || exit 1

echo "Git push..."
git add .
git commit -m "Auto update $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null || true
git push

echo "Deploying..."
vercel --prod

echo ""
echo "Checking site..."
curl -I https://learn-earnhub.vercel.app/ | head -1
curl -I https://learn-earnhub.vercel.app/student-dashboard.html | head -1
curl -I https://learn-earnhub.vercel.app/login.html | head -1

echo ""
echo "API Status:"
curl https://learn-earnhub.vercel.app/api/status
echo ""
