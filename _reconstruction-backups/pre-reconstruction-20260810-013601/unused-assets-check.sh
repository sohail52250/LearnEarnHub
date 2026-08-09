#!/data/data/com.termux/files/usr/bin/bash

echo "=== JS Files Not Referenced ==="

for f in $(find public/js -name "*.js"); do
    name=$(basename "$f")
    count=$(grep -R "$name" public --include="*.html" --include="*.js" | wc -l)
    if [ "$count" -eq 0 ]; then
        echo "$f"
    fi
done

echo
echo "=== CSS Files Not Referenced ==="

for f in $(find public -name "*.css"); do
    name=$(basename "$f")
    count=$(grep -R "$name" public --include="*.html" --include="*.js" | wc -l)
    if [ "$count" -eq 0 ]; then
        echo "$f"
    fi
done

echo
echo "=== DONE ==="
