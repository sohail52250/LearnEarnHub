#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting LearnEarnHub Dashboard Routes ==="


cp server.js server.backup.$(date +%s)


if ! grep -q "dashboard.js" server.js; then

cat >> server.js <<'JS'


// ===== LearnEarnHub Learning APIs =====

const dashboardAPI = require("./api/dashboard");
const certificateAPI = require("./api/certificate");


app.get("/api/dashboard/:user_id", dashboardAPI);

app.post("/api/certificate", certificateAPI);


// ===== End Learning APIs =====

JS

fi


echo "✅ API routes connected"


node -c server.js


if [ $? -eq 0 ]; then

echo "✅ server.js syntax OK"

else

echo "❌ server.js syntax error"

fi


echo ""
echo "Backup created:"
ls server.backup.* 2>/dev/null | tail -1


