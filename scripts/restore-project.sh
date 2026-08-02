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

