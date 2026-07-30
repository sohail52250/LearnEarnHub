
#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting Reputation Center ==="

FILES="
public/learner-dashboard.html
public/learner-progress.html
public/business-dashboard.html
public/business-dashboard-v2.html
"

for file in $FILES
do

if [ -f "$file" ]; then

if ! grep -q "reputation-center.html" "$file"; then

sed -i '/<nav>/a\
<a href="/reputation-center.html">⭐ Reputation</a>' "$file"

echo "Updated $file"

else

echo "Already connected: $file"

fi

fi

done

echo "=== Complete ==="

