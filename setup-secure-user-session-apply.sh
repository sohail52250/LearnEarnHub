#!/data/data/com.termux/files/usr/bin/bash

echo "=== Connecting Apply System With Supabase Session ==="

python - <<'PY'
from pathlib import Path

p=Path("public/task-marketplace.html")

if not p.exists():
    print("task-marketplace.html not found")
    raise SystemExit()

s=p.read_text()

old='let user_id=localStorage.getItem("user_id");'

new='''
let user_id=null;

try{

const {data:{session}} = await supabaseClient.auth.getSession();

if(session && session.user){
    user_id=session.user.id;
}

}catch(e){
    console.log("Session check failed");
}
'''

if old in s:
    s=s.replace(old,new)
    print("Session based user id added")
else:
    print("Old user id code not found - checking")

p.write_text(s)
PY


git add .
git commit -m "Connect applications with Supabase user session" || true
git push

vercel --prod

echo "=== Completed ==="
