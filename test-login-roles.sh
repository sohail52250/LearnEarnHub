#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "===== CHECK AUTH API ====="

sed -n '1,220p' api/auth.js


echo
echo "===== CHECK LOGIN RESPONSE FIELDS ====="

grep -R "token\|role\|user" api/auth.js


echo
echo "===== CHECK ROLE PAGES ====="

for f in \
admin-dashboard.html \
business-dashboard.html \
instructor-dashboard.html \
student-dashboard.html
do
 if [ -f public/$f ]; then
   echo "FOUND: $f"
 else
   echo "MISSING: $f"
 fi
done


echo
echo "===== CHECK SESSION FILES ====="

ls -la public/session-manager.js
ls -la public/login-connector.js
ls -la public/auth-guard.js


echo
echo "===== CHECK ROLE STORAGE ====="

grep -R "localStorage.setItem.*role" public | head -20


echo
echo "===== CHECK API PROTECTION ====="

grep -R "requireAuth\|requireRole" api | head -30


echo
echo "DONE"
