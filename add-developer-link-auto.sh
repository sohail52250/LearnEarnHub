#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Developer Portal link ==="

grep -RIl "</footer>" public | while read file
do
python - "$file" <<'PY'
import sys
from pathlib import Path

p=Path(sys.argv[1])
s=p.read_text()

link='<a href="/developer/login.html">Developer Portal</a>'

if "developer/login.html" not in s:
    s=s.replace("</footer>", link+"\n</footer>")
    p.write_text(s)
    print("Updated:",p)
else:
    print("Already exists:",p)
PY
done

git add .
git commit -m "Add Developer Portal link to website"
git push

echo "=== Done ==="
