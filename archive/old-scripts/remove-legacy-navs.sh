#!/data/data/com.termux/files/usr/bin/bash

echo "Cleaning legacy nav menus..."

find public -name "*.html" | while read file
do
    if grep -q 'id="global-header"' "$file"
    then
        cp "$file" "$file.bak"

        perl -0777 -i -pe '
        s|<nav\b[^>]*>.*?</nav>||gs;
        ' "$file"
    fi
done

echo "Done."
