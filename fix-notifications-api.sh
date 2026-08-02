#!/data/data/com.termux/files/usr/bin/bash

python3 <<'PY'
from pathlib import Path

candidates = [
    "api/notifications.js",
    "api/notifications/index.js"
]

for f in candidates:
    p = Path(f)
    if not p.exists():
        continue

    s = p.read_text()

    s = s.replace(
        "if(req.body.action===",
        "if(req.body && req.body.action==="
    )

    s = s.replace(
        "req.body.action",
        "(req.body?.action)"
    )

    p.write_text(s)
    print("Patched:", f)
PY

node -c server.js || exit 1

echo "✅ Notifications API patched"
