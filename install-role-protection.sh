#!/data/data/com.termux/files/usr/bin/bash

set -e

mkdir -p public/js

cat > public/js/role-guard.js <<'JS'
(function(){

const token = localStorage.getItem("token");

const path = window.location.pathname.toLowerCase();

if(!token){

const protectedPatterns = [
"/admin",
"/dashboard",
"/enterprise",
"/instructor",
"/sponsor",
"/seller",
"/notifications",
"/investment"
];

for(const p of protectedPatterns){
    if(path.includes(p)){
        window.location="/login.html";
        return;
    }
}

}

})();
JS


python3 <<'PY'
import glob

for f in glob.glob("public/*.html"):
    try:
        with open(f,encoding="utf8") as h:
            s=h.read()

        if "/js/role-guard.js" not in s:
            s=s.replace(
                "</body>",
                '<script src="/js/role-guard.js"></script>\n</body>'
            )

        with open(f,"w",encoding="utf8") as h:
            h.write(s)

    except:
        pass

print("Role guard injected.")
PY


git add .
git commit -m "Install role-based page protection" || true
git push

echo "DONE"
