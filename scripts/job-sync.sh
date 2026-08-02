#!/data/data/com.termux/files/usr/bin/bash


DATE=$(date)


echo "=== LearnEarnHub Job Sync $DATE ===" >> logs/job-sync.log


node scripts/job-sync-runner.js >> logs/job-sync.log 2>&1


echo "============================" >> logs/job-sync.log

