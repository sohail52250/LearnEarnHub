#!/data/data/com.termux/files/usr/bin/bash

python3 - <<'PY'

p="api/developer/dashboard.js"

s=open(p).read()

s=s.replace(
'.from("api_partner_keys")',
'.from("api_key_dashboard")'
)

open(p,"w").write(s)

PY


git add api/developer/dashboard.js

git commit -m "Fix developer dashboard api key view"

echo "Fixed"

