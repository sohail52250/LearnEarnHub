#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Learner Opportunity Dashboard ==="

mkdir -p api/jobs

cat > api/jobs/my-applications.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res)=>{

try{

const user_id=req.query.user_id;

if(!user_id){
 return res.status(400).json({
  error:"Missing user id"
 });
}


const {data,error}=await db
.from("job_applications")
.select("*")
.eq("user_id",user_id)
.order("created_at",{ascending:false});


if(error) throw error;


res.json({
 success:true,
 applications:data||[]
});


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

if "/api/jobs/my-applications" not in s:

 s += '''

const myApplications=require("./api/jobs/my-applications");

app.get(
 "/api/jobs/my-applications",
 myApplications
);
'''

 p.write_text(s)

 print("Learner applications route added")

else:
 print("Already exists")

PY


git add .
git commit -m "Add learner opportunity dashboard API" || true
git push

vercel --prod

echo "=== Completed ==="
