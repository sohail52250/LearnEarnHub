#!/data/data/com.termux/files/usr/bin/bash


echo "=== Auto Backup Running ==="


./scripts/backup-project.sh


echo ""

echo "Current backups:"

ls -lh backups/


