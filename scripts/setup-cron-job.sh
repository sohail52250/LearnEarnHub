#!/data/data/com.termux/files/usr/bin/bash


echo "Install Termux cron support:"


echo ""

echo "pkg install cronie"


echo ""

echo "Then add:"


echo "0 * * * * cd ~/EarnTask/LearnEarnHub && ./scripts/job-sync.sh"


echo ""

echo "This runs every hour."

