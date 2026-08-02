#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating developer role middleware ==="

cat > middleware/developer-role.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res,next)=>{

try{

const token=req.headers.authorization?.replace("Bearer ","");

if(!token){
 return res.status(401).json({
  error:"Missing session"
 });
}


const {data:userData,error:userError}=await db.auth.getUser(token);

if(userError || !userData.user){
 return res.status(401).json({
  error:"Invalid session"
 });
}


const {data:role,error:roleError}=await db
.from("user_roles")
.select("*")
.eq("user_id",userData.user.id)
.eq("role","developer")
.maybeSingle();


if(roleError) throw roleError;


if(!role){

 return res.status(403).json({
  error:"Developer role required"
 });

}


req.user=userData.user;

next();


}catch(e){

res.status(500).json({
 error:e.message
});

}

};
JS


python - <<'PY'
from pathlib import Path

p=Path("server.js")
s=p.read_text()

if 'developer-role' not in s:

 insert='''
const developerRole=require("./middleware/developer-role");

app.get(
 "/api/developer/secure-dashboard",
 developerRole,
 require("./api/developer/dashboard")
);
'''

 s=s.replace(
 "module.exports = app;",
 insert+"\nmodule.exports = app;"
 )

 p.write_text(s)
 print("Developer role route added")

else:
 print("Already exists")

PY


git add .
git commit -m "Add developer role authorization"
git push

echo "=== Completed ==="
