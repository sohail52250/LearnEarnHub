#!/data/data/com.termux/files/usr/bin/bash

echo "=== Project Backup ==="


DATE=$(date +"%Y-%m-%d-%H-%M")

BACKUP="backups/LearnEarnHub-$DATE.tar.gz"


tar -czf "$BACKUP" \
--exclude=node_modules \
--exclude=.git \
.


if [ $? -eq 0 ]; then

echo "✅ Project backup created"

echo "$BACKUP"

else

echo "❌ Backup failed"

fi

