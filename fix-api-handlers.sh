#!/data/data/com.termux/files/usr/bin/bash

echo "=== Fixing API Handlers ==="

python3 <<'PY'
from pathlib import Path

files = [
"api/employer-posts/index.js",
"api/opportunities/global.js"
]

for f in files:
    p=Path(f)
    if not p.exists():
        print("Missing:",f)
        continue

    s=p.read_text()

    s=s.replace(
        "if(req.body.action===",
        "if(req.body && req.body.action==="
    )

    p.write_text(s)
    print("Patched:",f)
PY

echo ""
echo "Running syntax check..."

node -c server.js

echo ""
echo "Done."
