#!/data/data/com.termux/files/usr/bin/bash

echo "Starting LearnEarnHub..."

cd ~/EarnTask/LearnEarnHub

echo "Installing dependencies..."
npm install

echo "Starting server..."
node server.js
