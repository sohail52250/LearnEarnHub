#!/data/data/com.termux/files/usr/bin/bash

echo "=== Fixing Developer Portal Authorization ==="

python - <<'PY'
from pathlib import Path

for f in [
"public/developer/login.html",
"public/developer/dashboard.html"
]:
    p=Path(f)

    if not p.exists():
        continue

    s=p.read_text()

    s=s.replace(
'''headers:{
"x-session-token":token
}''',
'''headers:{
"Authorization":"Bearer "+token
}'''
    )

    s=s.replace(
'''headers:{
"x-session-token":localStorage.getItem("dev_token")
}''',
'''headers:{
"Authorization":"Bearer "+localStorage.getItem("dev_token")
}'''
    )

    p.write_text(s)
    print("Fixed:",f)

PY

git add .
git commit -m "Fix developer portal auth header"
git push

vercel --prod

echo "=== Completed ==="
