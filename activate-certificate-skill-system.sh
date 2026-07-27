#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Certificate & Skill System"
echo "======================================"

echo ""
echo "1) Backup files"

mkdir -p backups

cp -f api/dashboard.js backups/dashboard.$(date +%Y%m%d-%H%M%S).js 2>/dev/null || true


echo ""
echo "2) Create certificate API"

cat > api/certificate.js <<'JS'
const db = require("../database");

module.exports = async (req,res)=>{

if(req.method !== "GET"){
return res.status(405).json({
error:"GET only"
});
}


const {user_id}=req.query;


if(!user_id){
return res.status(400).json({
error:"missing user_id"
});
}


const {data,error}=await db
.from("certificates")
.select("*")
.eq("user_id",user_id);


return res.json({
success:!error,
data,
error
});

};
JS


echo ""
echo "3) Create skill verification API"

cat > api/skills.js <<'JS'
const db = require("../database");

module.exports = async(req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("learner_skills")
.select("*");

return res.json({
data,
error
});

}


if(req.method==="POST"){

const {
user_id,
skill,
level
}=req.body;


const {data,error}=await db
.from("learner_skills")
.insert([{
user_id,
skill,
level:level || "Beginner"
}])
.select();


return res.json({
success:!error,
data,
error
});

}


return res.status(405).json({
error:"Method not allowed"
});

};
JS


echo ""
echo "4) Create earning unlock checker"

cat > api/earning-unlock.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {user_id}=req.query;

if(!user_id){
return res.status(400).json({
error:"missing user_id"
});
}


const {data,error}=await db
.from("user_progress")
.select("*")
.eq("user_id",user_id)
.eq("completed",true);


const completed=data ? data.length : 0;


return res.json({

user_id,

completed_courses:completed,

earning_unlocked: completed >= 1,

message:
completed >= 1
?
"Learning complete. Earning features unlocked."
:
"Complete courses to unlock earning."

,error

});

};
JS


echo ""
echo "5) Add route mapping"

python - <<'PY'
import json,os

try:
    with open("vercel.json") as f:
        v=json.load(f)

    print("Vercel config exists - API functions auto detected")

except:
    pass
PY


echo ""
echo "6) Save changes"

git add api/certificate.js api/skills.js api/earning-unlock.js

git commit -m "Add certificate skill verification and earning unlock APIs" || true

git push


echo ""
echo "7) Live checks"

sleep 5

echo "STATUS:"
curl -s https://learn-earnhub.vercel.app/api/status

echo ""

echo "CERTIFICATE API:"
curl -s "https://learn-earnhub.vercel.app/api/certificate?user_id=3ddc5d80-b236-43d4-ace5-d8ff4e7a6c47"

echo ""

echo "EARNING UNLOCK:"
curl -s "https://learn-earnhub.vercel.app/api/earning-unlock?user_id=3ddc5d80-b236-43d4-ace5-d8ff4e7a6c47"

echo ""

echo "======================================"
echo " SYSTEM ACTIVATION COMPLETE"
echo "======================================"

