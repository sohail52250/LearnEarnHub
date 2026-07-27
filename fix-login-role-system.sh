#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Find login files ==="

find public api -iname "*login*" -o -iname "*auth*" | sort


echo "=== Create login session helper ==="

cat > public/session-manager.js <<'JS'
function saveSession(data){

    if(data.token){
        localStorage.setItem(
            "token",
            data.token
        );
    }

    if(data.user){

        localStorage.setItem(
            "user",
            JSON.stringify(data.user)
        );

        localStorage.setItem(
            "role",
            data.user.role || "learner"
        );
    }

}


function logout(){

    localStorage.removeItem("token");
    localStorage.removeItem("user");
    localStorage.removeItem("role");

    location.href="/index.html";
}


function getUser(){

    try{
        return JSON.parse(
            localStorage.getItem("user")
        );
    }catch(e){
        return null;
    }

}
JS


echo "=== Update login pages ==="

for f in public/login.html public/login-v2.html public/signin.html
do

if [ -f "$f" ]; then

python3 - <<PY
p="$f"

with open(p,encoding="utf-8") as f:
 s=f.read()

if "session-manager.js" not in s:
 s=s.replace(
 "</head>",
 '<script src="/session-manager.js"></script></head>'
 )

with open(p,"w",encoding="utf-8") as f:
 f.write(s)

PY

fi

done


echo "=== Update auth API check ==="

python3 <<'PY'
import os

for p in [
"api/auth.js",
"api/users.js"
]:

 if os.path.exists(p):

  with open(p,encoding="utf-8") as f:
   s=f.read()

  if "role" not in s:

   print("Review needed:",p)

print("Auth scan complete")
PY


echo "=== Add role dashboard routing helper ==="

cat > public/role-router.js <<'JS'
function redirectByRole(){

const role=localStorage.getItem("role");

switch(role){

case "admin":
 location.href="/admin-dashboard.html";
 break;

case "business":
 location.href="/business-dashboard.html";
 break;

case "instructor":
 location.href="/instructor-dashboard.html";
 break;

default:
 location.href="/student-dashboard.html";

}

}
JS


git add public

git commit -m "Fix login session and role routing system" || true

git push


echo "DONE"
