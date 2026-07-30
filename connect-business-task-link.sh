
#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Business Task Creator link ==="


for file in public/business-dashboard.html public/business-dashboard-v2.html
do

if [ -f "$file" ]; then

if ! grep -q "business-task-create.html" "$file"; then

sed -i '/<h1>/a\
<nav>\
<a href="/business-task-create.html">🏢 Create Learner Task</a>\
</nav>' "$file"

echo "Updated $file"

else

echo "Already exists in $file"

fi

fi

done


echo "=== Complete ==="

