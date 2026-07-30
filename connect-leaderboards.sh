
#!/data/data/com.termux/files/usr/bin/bash

FILES="
public/reputation-center.html
public/learner-dashboard.html
public/business-dashboard.html
public/business-dashboard-v2.html
"

for file in $FILES
do

if [ -f "$file" ]; then

if ! grep -q "leaderboards.html" "$file"; then

sed -i '/<nav>/a\
<a href="/leaderboards.html">🏆 Leaderboards</a>' "$file"

echo "Updated $file"

fi

fi

done

echo "Leaderboards connected"

