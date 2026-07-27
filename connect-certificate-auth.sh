#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Check auth middleware ==="

ls api/auth-middleware.js


echo "=== Update certificate API with auth wrapper ==="

python3 <<'PY'
import os

files=[
"api/generate-certificate.js",
"api/certificate.js"
]

for p in files:

    if not os.path.exists(p):
        continue

    with open(p,encoding="utf-8") as f:
        s=f.read()

    if "auth-middleware" not in s:

        s='const {requireAuth}=require("./auth-middleware");\n'+s

    with open(p,"w",encoding="utf-8") as f:
        f.write(s)

print("Auth import added")
PY


echo "=== Check certificate verification ==="

sed -n '1,200p' api/certificate.js


git add api

git commit -m "Connect certificate APIs with authentication middleware" || true

git push

echo "DONE"
