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

