#!/data/data/com.termux/files/usr/bin/bash

echo "=== Cleaning old Developer Portal links ==="

for file in public/*backup* public/*before* public/*.backup*; do

if [ -f "$file" ]; then

python - "$file" <<'PY'
import sys
from pathlib import Path

p=Path(sys.argv[1])

try:
    s=p.read_text()
except:
    exit()

if "developer/login.html" in s:
    s=s.replace('<a href="/developer/login.html">Developer Portal</a>','')
    p.write_text(s)
    print("Cleaned:",p)
PY

fi

done


echo "=== Checking active files ==="

grep -RIl "developer/login.html" public/index.html public/global-footer.html 2>/dev/null || true


git add .
git commit -m "Clean developer portal links from backup files" || true
git push

echo "=== Deploying ==="

vercel --prod

echo "=== Completed ==="
