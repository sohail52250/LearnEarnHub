#!/data/data/com.termux/files/usr/bin/bash

echo "Fixing regenerate-key API table..."

FILE="api/developer/regenerate-key.js"

if [ -f "$FILE" ]; then
  sed -i 's/\.from("api_partner_keys")/.from("developer_keys")/g' "$FILE"
  echo "Updated regenerate-key.js"
else
  echo "File not found: $FILE"
fi

echo "Checking result:"
grep -n "from(" "$FILE"

echo "Done."
