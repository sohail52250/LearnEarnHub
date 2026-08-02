#!/data/data/com.termux/files/usr/bin/bash

python3 - <<'PY'

p="services/ai/job-matching-bridge.js"

s=open(p).read()

s=s.replace(
'status:"new"',
'status:"new",\nconfidence: score >= 90 ? "Excellent Match" : score >= 70 ? "Good Match" : "Possible Match"'
)

s=s.replace(
'.insert(recommendations);',
'.upsert(recommendations,{onConflict:"user_id,opportunity_id"});'
)

open(p,"w").write(s)

print("AI matching upgraded")

PY

node -c services/ai/job-matching-bridge.js

