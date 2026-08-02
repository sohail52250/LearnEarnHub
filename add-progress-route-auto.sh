#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Progress API Route ==="

SERVER="server.js"

if grep -q 'routes/progress' $SERVER; then
  echo "✅ Progress route already added"
else

  cp $SERVER ${SERVER}.backup-progress

  sed -i '/express.static("public")/a\
const progressRoutes = require("./routes/progress");\
app.use("/api/progress", progressRoutes);' $SERVER

  echo "✅ Progress route added"
fi

echo ""
echo "Checking:"
grep -n "progress" $SERVER

