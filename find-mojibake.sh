#!/data/data/com.termux/files/usr/bin/bash

echo "=== Searching corrupted UTF-8 patterns ==="

grep -R "ðŸ\|Ø\|Ù\|Â" public \
--include="*.html" \
--include="*.js" \
--include="*.json" \
| head -100

echo
echo "DONE"
