
#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting Business Task Manager ==="

for file in public/business-dashboard.html public/business-dashboard-v2.html
do

if [ -f "$file" ]; then

if ! grep -q "business-task-manager.html" "$file"; then

sed -i '/business-task-create.html/a\
<a href="/business-task-manager.html">📋 Manage Tasks</a>' "$file"

echo "Updated $file"

else

echo "Already connected: $file"

fi

fi

done

echo "=== Done ==="

