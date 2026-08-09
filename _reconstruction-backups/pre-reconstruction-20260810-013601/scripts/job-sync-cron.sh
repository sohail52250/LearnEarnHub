#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

node scripts/run-job-sync.js

node scripts/run-ai-job-matching.js

node scripts/run-ai-alert-engine.js

echo "AI Job Cycle Completed"
