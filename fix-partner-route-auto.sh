#!/data/data/com.termux/files/usr/bin/bash

echo "=== Fix Partner Dashboard Route ==="

python3 - <<'PY'
import json

with open("vercel.json") as f:
    data=json.load(f)

routes=data.get("routes",[])

new_routes=[]

added=False

for r in routes:
    if r.get("src")=="/(.*\\.(js|html|css|png|jpg|jpeg|svg|ico))":
        new_routes.append(r)

    if not added:
        new_routes.append({
            "src":"/partner/(.*)",
            "dest":"/public/partner/$1"
        })
        new_routes.append({
            "src":"/swagger/(.*)",
            "dest":"/public/swagger/$1"
        })
        new_routes.append({
            "src":"/developer/(.*)",
            "dest":"/public/developer/$1"
        })
        added=True

    if r.get("src") not in [
        "/(.*\\.(js|html|css|png|jpg|jpeg|svg|ico))"
    ]:
        new_routes.append(r)

data["routes"]=new_routes

with open("vercel.json","w") as f:
    json.dump(data,f,indent=2)

PY


git add vercel.json

git commit -m "Fix partner swagger developer static routes"

echo "Route fixed"

