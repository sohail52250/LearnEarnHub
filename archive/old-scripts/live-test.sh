#!/data/data/com.termux/files/usr/bin/bash

URL="https://learn-earnhub.vercel.app"

echo "===== HOMEPAGE ====="
curl -I $URL

echo
echo "===== API STATUS ====="
curl -s $URL/api/status

echo
echo "===== COURSES ====="
curl -s $URL/api/courses

echo
echo "===== USERS API ====="
curl -s $URL/api/users

echo
echo "===== AUTH API ====="
curl -s $URL/api/auth

echo
echo "===== DASHBOARD API ====="
curl -s $URL/api/dashboard

echo
echo "===== ADS API ====="
curl -s $URL/api/ads

echo
echo "===== COMPLETE COURSE ====="
curl -s $URL/api/complete-course

echo
echo "===== DONE ====="
