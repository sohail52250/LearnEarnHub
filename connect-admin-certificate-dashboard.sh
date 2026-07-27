#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Backup admin certificate page ==="

cp public/admin-certificates.html public/admin-certificates-before-token.html


echo "=== Update admin certificate JavaScript ==="

python3 <<'PY'

p="public/admin-certificates.html"

with open(p,encoding="utf8") as f:
    s=f.read()


s=s.replace(
'''
await fetch(
"/api/admin-certificate-control",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action,

certificate_code:code,

reason

})

}
);
''',
'''
let token=localStorage.getItem("token");

if(!token){

alert("Please login as admin");

return;

}


let response=await fetch(
"/api/admin-certificate-control",
{

method:"POST",

headers:{
"Content-Type":"application/json",
"Authorization":"Bearer "+token
},

body:JSON.stringify({

action,

certificate_code:code,

reason

})

}
);


let result=await response.json();


if(!response.ok){

alert(result.error || "Update failed");

return;

}

'''
)


with open(p,"w",encoding="utf8") as f:
    f.write(s)

PY


echo "=== Add dashboard menu link ==="

python3 <<'PY'

import glob

for p in glob.glob("public/*admin*dashboard*.html"):

    try:

        with open(p,encoding="utf8") as f:
            s=f.read()

        link='''<a href="/admin-certificates.html">🏆 Certificate Control</a>'''

        if "admin-certificates.html" not in s:

            s=s.replace(
            "</body>",
            link+"</body>"
            )

            with open(p,"w",encoding="utf8") as f:
                f.write(s)

            print("updated",p)

    except:
        pass

PY


echo "=== Git save ==="

git add .

git commit -m "Connect admin certificate dashboard with authentication token" || true

git push


echo "DONE"
