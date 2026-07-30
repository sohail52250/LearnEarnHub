#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Business Links to Global Header ==="

cp public/global-header.html public/global-header.html.bak 2>/dev/null

python - <<'PY'
from pathlib import Path

file = Path("public/global-header.html")

if not file.exists():
    print("global-header.html not found")
    exit()

text = file.read_text()

links = '''
<a href="/business-register.html">
🏢 Register Your Business
</a>

<a href="/business-marketplace.html">
🤝 Business Marketplace
</a>
'''

if "business-register.html" not in text:
    text = text.replace("</nav>", links + "\n</nav>")

file.write_text(text)

print("Business links added")
PY

echo "=== Completed ==="

