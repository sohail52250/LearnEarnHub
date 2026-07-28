#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

echo "Removing old admin-dashboard references..."

grep -RIl "admin-dashboard.html" public | while read file
do
  sed -i 's/admin-dashboard\.html/admin-control-dashboard.html/g' "$file"
done

echo "Checking broken static pages..."

for page in market.html post-ad.html admin-control-dashboard.html student-dashboard.html business-dashboard.html
do
  echo -n "$page : "
  curl -Ls -o /dev/null -w "%{http_code}\n" "https://learn-earnhub.vercel.app/$page"
done

git add public
git commit -m "Final navigation cleanup and dashboard link fix" || true
git push

echo "Done"
