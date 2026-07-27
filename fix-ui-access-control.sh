#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Backup ==="
cp public/index.html public/index-before-ui-security-$(date +%Y%m%d-%H%M%S).html


echo "=== Center UI CSS ==="

python3 <<'PY'
p="public/index.html"

with open(p,encoding="utf-8") as f:
    s=f.read()

css="""

<style>
body{
 text-align:center;
}

.hero,
.card,
.grid,
footer{
 text-align:center;
}

.grid{
 justify-items:center;
}

.card{
 max-width:420px;
 width:100%;
}

.card a{
 display:inline-block;
}

h1,h2,h3,p{
 text-align:center;
}

@media(max-width:600px){
 body{
  padding:10px;
 }
 .card{
  width:100%;
 }
}
</style>

"""

if "justify-items:center" not in s:
    s=s.replace("</head>",css+"</head>")

with open(p,"w",encoding="utf-8") as f:
    f.write(s)

print("Centered")
PY


echo "=== Create access guard ==="

cat > public/auth-guard.js <<'JS'
(function(){

const path = location.pathname;

const protectedPages = {

"/admin-dashboard.html":"admin",
"/admin-control-center.html":"admin",

"/instructor-dashboard.html":"instructor",
"/instructor-course.html":"instructor",

"/business-dashboard.html":"business",
"/business-dashboard-v2.html":"business",
"/business-profile-complete.html":"business",

"/student-dashboard.html":"learner",
"/learner-dashboard-v2.html":"learner"

};


const requiredRole = protectedPages[path];

if(!requiredRole) return;


let user=null;

try{
 user=JSON.parse(localStorage.getItem("user"));
}catch(e){}


if(!user){

 alert("Please login first");
 location.href="/login.html";
 return;

}


if(user.role!==requiredRole && user.role!=="admin"){

 alert("Access denied");
 location.href="/index.html";

}


})();
JS


echo "=== Add guard to protected pages ==="

for f in \
admin-dashboard.html \
admin-control-center.html \
instructor-dashboard.html \
instructor-course.html \
business-dashboard.html \
business-dashboard-v2.html \
business-profile-complete.html \
student-dashboard.html \
learner-dashboard-v2.html
do

 if [ -f public/$f ]; then

 python3 - <<PY
p="public/$f"

with open(p,encoding="utf-8") as f:
 s=f.read()

if "auth-guard.js" not in s:
 s=s.replace(
 "</head>",
 '<script src="/auth-guard.js"></script></head>'
 )

with open(p,"w",encoding="utf-8") as f:
 f.write(s)

PY

 fi

done


echo "=== Commit ==="

git add public

git commit -m "Center UI and protect dashboard pages" || true

git push


echo "DONE"
