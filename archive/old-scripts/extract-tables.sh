#!/data/data/com.termux/files/usr/bin/bash

grep -R '\.from("' public api \
  --include="*.js" \
  --include="*.html" \
| sed -E 's/.*\.from\("([^"]+)".*/\1/' \
| sort -u > all_tables.txt

echo "===== TABLES ====="
cat all_tables.txt
echo
echo "COUNT:"
wc -l all_tables.txt
