#!/data/data/com.termux/files/usr/bin/bash

BASE="https://learn-earnhub.vercel.app"
REPORT="link-audit-report-v2.txt"

echo "===== LearnEarnHub Link Audit V2 =====" | tee $REPORT

grep -rhoE 'href="[^"]+\.html[^"]*"' public \
| sed 's/href="//;s/"//' \
| sed 's/[?#].*//' \
| grep -v '\${' \
| sort -u > html-links-v2.txt

TOTAL=$(wc -l < html-links-v2.txt)

echo "Links checked: $TOTAL" | tee -a $REPORT
echo "" | tee -a $REPORT

BROKEN=0

while read -r link
do
    [ -z "$link" ] && continue

    case "$link" in
        http*) continue ;;
    esac

    CODE=$(curl -Ls -o /dev/null -w "%{http_code}" "$BASE$link")

    if [ "$CODE" != "200" ]; then
        echo "BROKEN [$CODE] $link" | tee -a $REPORT
        BROKEN=$((BROKEN+1))
    fi

done < html-links-v2.txt

echo "" | tee -a $REPORT
echo "Broken links: $BROKEN" | tee -a $REPORT
