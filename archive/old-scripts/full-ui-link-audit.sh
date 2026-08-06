#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Full UI Audit ==="

BASE="https://learn-earnhub.vercel.app"

echo
echo "=== Checking HTML Pages ==="

find public -name "*.html" | while read file
do
 page=${file#public/}
 code=$(curl -s -o /dev/null -w "%{http_code}" "$BASE/$page")

 if [ "$code" = "200" ]; then
   echo "OK $page"
 else
   echo "BROKEN $page ($code)"
 fi
done


echo
echo "=== Checking Buttons ==="

grep -R "<button\|<a " public --include="*.html" \
| wc -l


echo
echo "=== Checking Language Support ==="

grep -R "English\|اردو\|العربية\|中文\|language" public \
--include="*.html" | head -30


echo
echo "=== Checking Zoom Accessibility ==="

grep -R "viewport" public \
--include="*.html" | head -5


echo
echo "=== Checking API Pages ==="

for api in \
api/status \
api/developer/dashboard \
api/external/jobs-feed \
api/partner/jobs

do

echo "$api"

curl -s "$BASE/$api"

echo

done


echo
echo "=== Checking Broken Internal Links ==="

grep -Roh 'href="[^"]*"' public \
--include="*.html" \
| sed 's/href="//;s/"//' \
| grep "^/" \
| while read link
do

code=$(curl -s -o /dev/null -w "%{http_code}" "$BASE$link")

if [ "$code" != "200" ]; then
echo "BROKEN $link"
fi

done


echo
echo "=== Audit Complete ==="

