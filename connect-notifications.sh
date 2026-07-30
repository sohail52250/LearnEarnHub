#!/data/data/com.termux/files/usr/bin/bash

for file in \
public/business-dashboard.html \
public/business-dashboard-v2.html \
public/learner-dashboard.html \
public/learner-progress.html
do

if [ -f "$file" ]; then

if ! grep -q "notifications.html" "$file"; then

sed -i '/<nav>/a\
<a href="/notifications.html">🔔 Notifications</a>' "$file"

fi

fi

done

echo "Notifications connected"
