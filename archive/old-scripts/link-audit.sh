#!/data/data/com.termux/files/usr/bin/bash

BASE="https://learn-earnhub.vercel.app"
REPORT="link-audit-report.txt"

echo "===== LearnEarnHub Link Audit =====" | tee $REPORT
echo "Date: $(date)" | tee -a $REPORT
echo "" | tee -a $REPORT

echo "Scanning HTML links..." | tee -a $REPORT

grep -rhoE 'href="[^"]+\.html[^"]*"' public \
| sed 's/href="//;s/"//' \
| sed 's/[?#].*//' \
| sort -u > html-links.txt

TOTAL=$(wc -l < html-links.txt)

echo "Total links found: $TOTAL" | tee -a $REPORT
echo "" | tee -a $REPORT

BROKEN=0

while read -r link
do
    [ -z "$link" ] && continue

    # Ignore external links
    case "$link" in
        http*) continue ;;
    esac

    URL="$BASE/$link"

    CODE=$(curl -Ls -o /dev/null -w "%{http_code}" "$URL")

    if [ "$CODE" != "200" ]; then
        echo "BROKEN [$CODE] $link" | tee -a $REPORT
        BROKEN=$((BROKEN+1))
    fi

done < html-links.txt

echo "" | tee -a $REPORT
echo "===== SUMMARY =====" | tee -a $REPORT
echo "Checked: $TOTAL" | tee -a $REPORT
echo "Broken: $BROKEN" | tee -a $REPORT

echo "" | tee -a $REPORT
echo "Report saved: $REPORT"

