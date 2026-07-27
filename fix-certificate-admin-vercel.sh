#!/data/data/com.termux/files/usr/bin/bash

set -e

cp api/admin-certificate-control.js api/admin-certificate-control-before-vercel-fix.js


python3 <<'PY'
p="api/admin-certificate-control.js"

with open(p,encoding="utf8") as f:
    s=f.read()


s=s.replace(
'const {requireAuth,requireAdmin}=require("./auth-middleware");',
'const {requireAuth,requireAdmin}=require("./auth-middleware");'
)


s=s.replace(
'module.exports=[requireAuth,requireAdmin,async(req,res)=>{',
'''
module.exports=async(req,res)=>{

try{

await new Promise((resolve,reject)=>{

requireAuth(req,res,()=>{

requireAdmin(req,res,()=>{

resolve();

});

});

});

'''
)


s=s.replace(
'\\n];',
'''
}catch(err){

console.error(err);

return res.status(500).json({
error:"Admin certificate control failed"
});

}

};
'''
)


with open(p,"w",encoding="utf8") as f:
    f.write(s)

PY


git add api/admin-certificate-control.js

git commit -m "Fix certificate admin API for Vercel serverless"

git push

echo "DONE"
