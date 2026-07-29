#!/data/data/com.termux/files/usr/bin/bash

echo "Creating backup..."
mkdir -p backup-nav-cleanup

find public -name "*.html" | while read f
do
    if grep -q 'id="global-header"' "$f"; then

        cp "$f" "backup-nav-cleanup/$(basename "$f")"

        perl -0777 -i -pe '
        s#<nav[^>]*>.*?</nav>##gs;
        ' "$f"

        echo "Cleaned: $f"
    fi
done

echo ""
echo "Done."
echo "Review changes, then:"
echo "git add ."
echo "git commit -m 'Remove legacy navigation blocks'"
echo "git push"
