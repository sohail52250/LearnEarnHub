#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating Partner Jobs API ==="

mkdir -p api/partner

cat > api/partner/jobs.js <<'JS'
const { createClient } = require("@supabase/supabase-js");
require("dotenv").config();

const db = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports = async(req,res)=>{
 try{

  if(req.method==="GET"){
   const {data,error}=await db
    .from("partner_jobs")
    .select("*")
    .eq("status","approved")
    .order("created_at",{ascending:false});

   if(error) throw error;

   return res.json({
    success:true,
    jobs:data||[]
   });
  }

  if(req.method==="POST"){

   const {company,title,description,reward,currency,website,country,deadline}=req.body;

   const {data,error}=await db
    .from("partner_jobs")
    .insert({
      company,
      title,
      description,
      reward,
      currency,
      website,
      country,
      deadline,
      status:"pending"
    })
    .select()
    .single();

   if(error) throw error;

   return res.json({
    success:true,
    job:data
   });
  }

  res.status(405).json({
   error:"Method not allowed"
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

if 'api/partner/jobs' not in s:
    s += '''

const partnerJobs=require("./api/partner/jobs");

app.get(
 "/api/partner/jobs",
 partnerJobs
);

app.post(
 "/api/partner/jobs",
 partnerJobs
);
'''
    p.write_text(s)
    print("Partner Jobs API registered")
else:
    print("Partner Jobs API already exists")
PY

git add .
git commit -m "Add partner jobs API" || true
git push
vercel --prod

echo "=== Completed ==="
