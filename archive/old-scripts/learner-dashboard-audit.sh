
#!/data/data/com.termux/files/usr/bin/bash

echo "=== LEARNER DASHBOARD AUDIT ==="

echo
echo "=== learner-dashboard.html ==="
sed -n '1,220p' public/learner-dashboard.html

echo
echo "=== learner-dashboard-v2.html ==="
sed -n '1,220p' public/learner-dashboard-v2.html

echo
echo "=== learner-dashboard.js ==="
sed -n '1,260p' public/learner-dashboard.js

echo
echo "=== References ==="
grep -Rni "learner-dashboard" public | head -50

echo
echo "=== Audit Complete ==="

