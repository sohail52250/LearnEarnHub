#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Final Audit ==="

echo
echo "=== Core Modules ==="

for f in \
public/business-register.html \
public/business-marketplace.html \
public/business-dashboard.html \
public/task-marketplace.html \
public/recommended-tasks.html \
public/learner-progress.html \
public/reputation-center.html \
public/leaderboards.html \
public/premium-center.html \
public/notifications.html \
public/deal-room-center.html
do
    [ -f "$f" ] && echo "✅ $f" || echo "❌ $f"
done

echo
echo "=== JS Modules ==="

for f in \
public/task-recommendations.js \
public/learner-progress.js \
public/reputation-center.js \
public/leaderboards.js \
public/premium-center.js \
public/notifications.js \
public/deal-room-center.js
do
    [ -f "$f" ] && echo "✅ $f" || echo "❌ $f"
done

echo
echo "=== Supabase References ==="
grep -R "supabase-config.js" public | wc -l

echo
echo "=== Git Status ==="
git status --short

echo
echo "=== Audit Complete ==="
