#!/data/data/com.termux/files/usr/bin/bash

echo "===== ANALYTICS ====="
sed -n '1,200p' api/analytics.js 2>/dev/null

echo ""
echo "===== EMPLOYER POSTS ====="
sed -n '1,200p' api/employer-posts/index.js 2>/dev/null

echo ""
echo "===== OPPORTUNITIES ====="
sed -n '1,200p' api/opportunities/global.js 2>/dev/null

echo ""
echo "===== SERVER ROUTES ====="
grep -n "analytics\|employer\|opportunities" server.js 2>/dev/null

echo ""
echo "===== END ====="
