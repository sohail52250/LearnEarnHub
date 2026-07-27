#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Backup login files ==="

cp public/login.html public/login-backup-$(date +%Y%m%d-%H%M%S).html 2>/dev/null || true
cp public/login-v2.html public/login-v2-backup-$(date +%Y%m%d-%H%M%S).html 2>/dev/null || true


echo "=== Create login connector ==="

cat > public/login-connector.js <<'JS'
async function loginUser(email,password){

    try{

        const response = await fetch("/api/auth",{

            method:"POST",

            headers:{
                "Content-Type":"application/json"
            },

            body:JSON.stringify({
                email,
                password
            })

        });


        const data = await response.json();


        if(!response.ok){

            alert(data.error || "Login failed");
            return false;

        }


        if(typeof saveSession==="function"){

            saveSession(data);

        }else{

            localStorage.setItem(
                "token",
                data.token || ""
            );

            localStorage.setItem(
                "user",
                JSON.stringify(data.user || {})
            );

            localStorage.setItem(
                "role",
                data.user?.role || "learner"
            );

        }


        alert("Login successful");


        const role=data.user?.role || "learner";


        if(role==="admin"){

            location.href="/admin-dashboard.html";

        }else if(role==="business"){

            location.href="/business-dashboard.html";

        }else if(role==="instructor"){

            location.href="/instructor-dashboard.html";

        }else{

            location.href="/student-dashboard.html";

        }


        return true;


    }catch(error){

        console.error(error);

        alert("Server error");

        return false;

    }

}
JS


echo "=== Add connector to login pages ==="

for f in public/login.html public/login-v2.html
do

if [ -f "$f" ]; then

python3 - <<PY
p="$f"

with open(p,encoding="utf-8") as f:
 s=f.read()

if "login-connector.js" not in s:

 s=s.replace(
 "</body>",
 '<script src="/session-manager.js"></script>\n<script src="/login-connector.js"></script>\n</body>'
 )

with open(p,"w",encoding="utf-8") as f:
 f.write(s)

PY

fi

done


echo "=== Commit ==="

git add public

git commit -m "Connect login API with JWT session and role redirect" || true

git push


echo "DONE"
