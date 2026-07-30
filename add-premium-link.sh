#!/data/data/com.termux/files/usr/bin/bash

FILES="
public/business-dashboard.html
public/business-dashboard-v2.html
"

for file in $FILES
do
    if [ -f "$file" ]; then

        if ! grep -q "premium-center.html" "$file"; then

            sed -i '/<nav>/a\
<a href="/premium-center.html">💎 Premium Center</a>' "$file"

            echo "Added Premium link to $file"

        else
            echo "Already exists in $file"
        fi

    fi
done

echo "Premium navigation update complete"
