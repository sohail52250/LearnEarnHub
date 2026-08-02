#!/data/data/com.termux/files/usr/bin/bash

echo "Fixing developer key API table..."

FILE="api/developer/key-control.js"

if [ -f "$FILE" ]; then
  sed -i 's/\.from("api_partner_keys")/.from("developer_keys")/g' "$FILE"
  echo "Updated key-control.js"
else
  echo "File not found: $FILE"
fi

echo "Checking result:"
grep -n "from(" "$FILE"

echo "Done."
