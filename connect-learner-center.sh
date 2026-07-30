
#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding learner navigation links ==="


# Add links to learner dashboard if not already present

if ! grep -q "recommended-tasks.html" public/learner-dashboard.html; then

sed -i '/<h1>/a\
<nav>\
<a href="/recommended-tasks.html">🎯 Recommended Tasks</a> |\
<a href="/learner-progress.html">📈 Progress Center</a> |\
<a href="/task-marketplace.html">📋 Task Marketplace</a>\
</nav>' public/learner-dashboard.html

fi


# Add same navigation to progress page

if ! grep -q "learner-dashboard.html" public/learner-progress.html; then

sed -i '/<h1>/a\
<nav>\
<a href="/learner-dashboard.html">🏠 Dashboard</a> |\
<a href="/recommended-tasks.html">🎯 Tasks</a> |\
<a href="/task-marketplace.html">📋 Marketplace</a>\
</nav>' public/learner-progress.html

fi


echo "=== Connection complete ==="

