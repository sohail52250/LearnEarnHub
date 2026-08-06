#!/data/data/com.termux/files/usr/bin/bash

echo "=== Pages containing legacy <nav> tags ==="
grep -Rli "<nav" public \
| grep -v "global-header.html" \
| sort > legacy-nav-pages.txt

wc -l legacy-nav-pages.txt
echo
cat legacy-nav-pages.txt
