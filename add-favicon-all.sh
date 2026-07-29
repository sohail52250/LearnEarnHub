#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

COUNT=0

find public -name "*.html" | while read file
do
    if ! grep -q 'favicon.png' "$file"; then
        sed -i '/<\/head>/i <link rel="icon" type="image/png" href="/favicon.png">' "$file"
        echo "Updated: $file"
    fi
done

echo "Favicon update completed"
