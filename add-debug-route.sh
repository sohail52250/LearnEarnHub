#!/data/data/com.termux/files/usr/bin/bash

FILE="server.js"

if grep -q "debug/check-db" "$FILE"; then
  echo "Debug route already exists"
else
  cat >> "$FILE" <<'JS'

const debugDb = require("./api/debug/check-db");

app.get("/api/debug/check-db", debugDb);
JS
  echo "Debug route added"
fi

git add .
git commit -m "Register database debug route"
git push

echo "Done"
