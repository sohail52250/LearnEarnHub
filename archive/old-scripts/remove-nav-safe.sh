#!/data/data/com.termux/files/usr/bin/bash

find public -name "*.html" | while read file
do
  if grep -q 'id="global-header"' "$file"; then
    python3 - "$file" <<'PY'
import re, sys

f = sys.argv[1]

with open(f, "r", encoding="utf-8", errors="ignore") as fp:
    data = fp.read()

new_data = re.sub(
    r'<nav\b[^>]*>.*?</nav>',
    '',
    data,
    flags=re.IGNORECASE | re.DOTALL
)

if new_data != data:
    with open(f, "w", encoding="utf-8") as fp:
        fp.write(new_data)
    print("Updated:", f)
PY
  fi
done

echo "Navigation cleanup completed."
