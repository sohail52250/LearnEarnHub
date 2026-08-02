#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Partner Applicant Dashboard ==="

mkdir -p api/partner

cat > api/partner/applicants.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res)=>{

try{

const job_title=req.query.job_title;

if(!job_title){
 return res.status(400).json({
  error:"Missing job title"
 });
}


const {data,error}=await db
.from("job_applications")
.select("*")
.eq("job_title",job_title)
.order("created_at",{ascending:false});


if(error) throw error;


res.json({
 success:true,
 applicants:data || []
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

if "/api/partner/applicants" not in s:

 s += '''

const partnerApplicants=require("./api/partner/applicants");

app.get(
 "/api/partner/applicants",
 partnerApplicants
);
'''

 p.write_text(s)
 print("Partner applicant route added")

else:
 print("Already exists")

PY


git add .
git commit -m "Add partner applicant dashboard API" || true
git push

vercel --prod

echo "=== Completed ==="
