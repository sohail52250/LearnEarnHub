#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Find existing auth files ==="

find api -maxdepth 1 -iname "*auth*" -o -iname "*middleware*"


echo "=== Backup ==="

cp api/admin-certificate-control.js api/admin-certificate-control-backup.js 2>/dev/null || true


echo "=== Create reusable auth middleware ==="

cat > api/auth-middleware.js <<'JS'
const jwt=require("jsonwebtoken");


function requireAuth(req,res,next){

try{

const header=req.headers.authorization;


if(!header){

return res.status(401).json({
error:"Authentication required"
});

}


const token=header.replace("Bearer ","");


const decoded=jwt.verify(
token,
process.env.JWT_SECRET || "learn-earnhub-secret"
);


req.user=decoded;


next();


}catch(err){

return res.status(401).json({
error:"Invalid token"
});

}

}


function requireAdmin(req,res,next){

if(!req.user){

return res.status(401).json({
error:"Login required"
});

}


if(
req.user.role!=="admin" &&
req.user.is_admin!==true
){

return res.status(403).json({
error:"Admin access required"
});

}


next();

}


module.exports={
requireAuth,
requireAdmin
};
JS



echo "=== Secure admin certificate API ==="

python3 <<'PY'

p="api/admin-certificate-control.js"

with open(p,encoding="utf8") as f:
 s=f.read()


if "auth-middleware" not in s:

 s='const {requireAuth,requireAdmin}=require("./auth-middleware");\n'+s


s=s.replace(
"module.exports=async(req,res)=>{",
"module.exports=[requireAuth,requireAdmin,async(req,res)=>{"
)


s=s.rstrip()+"\n];\n"


with open(p,"w",encoding="utf8") as f:
 f.write(s)

PY



echo "=== Add frontend protection ==="

python3 <<'PY'

p="public/admin-certificates.html"

with open(p,encoding="utf8") as f:
 s=f.read()


check="""

<script>

if(!localStorage.getItem("token")){

window.location="/login.html";

}

</script>

"""


if "localStorage.getItem" not in s:

 s=s.replace(
 "<body>",
 "<body>"+check
 )


with open(p,"w",encoding="utf8") as f:
 f.write(s)

PY



echo "=== Commit ==="

git add .

git commit -m "Secure certificate admin dashboard authentication" || true

git push


echo "DONE"
