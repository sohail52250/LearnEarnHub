#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Learner Apply System ==="

mkdir -p api/jobs

cat > api/jobs/apply.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res)=>{

try{

if(req.method!=="POST"){
 return res.status(405).json({
  error:"Method not allowed"
 });
}

const {
 job_title,
 source,
 apply_url,
 user_id
}=req.body;


const {data,error}=await db
.from("job_applications")
.insert({
 job_title,
 source,
 apply_url,
 user_id,
 status:"saved"
})
.select()
.single();


if(error) throw error;


res.json({
 success:true,
 application:data
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

if "/api/jobs/apply" not in s:

 s += '''

const jobApply=require("./api/jobs/apply");

app.post(
 "/api/jobs/apply",
 jobApply
);
'''

 p.write_text(s)

 print("Route added")

else:
 print("Already exists")

PY


git add .
git commit -m "Add learner job apply system" || true
git push

vercel --prod

echo "=== Completed ==="
