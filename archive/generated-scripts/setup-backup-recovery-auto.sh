#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Backup & Recovery Setup ==="


mkdir -p backups scripts



cat > scripts/backup-project.sh <<'SH'
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

SH



chmod +x scripts/backup-project.sh



cat > scripts/restore-project.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash


echo "=== LearnEarnHub Restore ==="


if [ -z "$1" ]; then

echo "Usage:"
echo "./scripts/restore-project.sh backups/file.tar.gz"

exit 1

fi



tar -xzf "$1"


if [ $? -eq 0 ]; then

echo "✅ Restore completed"

else

echo "❌ Restore failed"

fi

SH



chmod +x scripts/restore-project.sh



cat > scripts/health-check.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash


echo "=== LearnEarnHub Health Check ==="


echo ""

echo "Node:"

node -v


echo ""

echo "NPM:"

npm -v


echo ""

echo "Server syntax:"

node -c server.js


echo ""

echo "Files:"

ls server.js package.json


echo ""

echo "✅ Health check finished"

SH



chmod +x scripts/health-check.sh



cat > scripts/auto-backup.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash


echo "=== Auto Backup Running ==="


./scripts/backup-project.sh


echo ""

echo "Current backups:"

ls -lh backups/


SH



chmod +x scripts/auto-backup.sh



node -c server.js



echo ""

echo "✅ Backup & Recovery System Created"

echo ""

echo "Commands:"

echo "./scripts/backup-project.sh"

echo "./scripts/restore-project.sh backup-file"

echo "./scripts/health-check.sh"

echo "./scripts/auto-backup.sh"


