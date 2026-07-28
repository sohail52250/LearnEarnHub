#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

echo "Fixing admin-dashboard links..."

grep -RIl "admin-dashboard.html" public | while read file
do
    echo "Updating $file"
    sed -i 's/admin-dashboard\.html/admin-control-dashboard.html/g' "$file"
done

echo "Checking remaining:"
grep -R "admin-dashboard.html" public || echo "OK - removed"

git add public
git commit -m "Fix admin dashboard navigation link"
git push

lh-deploy
