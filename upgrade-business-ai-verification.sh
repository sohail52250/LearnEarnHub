#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Business AI Upgrade"
echo "======================================"

mkdir -p database


cat > database/business_ai_verification_upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS business_profiles (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
business_name text,
category text,
description text,
phone text,
city text,
verified boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_verification_requests (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
documents text,
status text DEFAULT 'pending',
admin_notes text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS learner_skills (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
skill_name text,
level text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS ai_matches (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
learner_id uuid,
match_score integer DEFAULT 0,
reason text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_dashboard_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
action text,
details text,
created_at timestamp DEFAULT now()
);

SQL



echo "Creating business dashboard API..."

cat > api/business-dashboard.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const business_id=req.query.business_id;


const {data,error}=await db
.from("business_profiles")
.select("*")
.eq("id",business_id)
.single();


return res.json({
success:!error,
business:data,
error
});

};
JS



echo "Creating business registration API..."

cat > api/business-register.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("business_profiles")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating AI matching API..."

cat > api/ai-match.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {
business_id,
learner_id,
match_score,
reason
}=req.body;


const {data,error}=await db
.from("ai_matches")
.insert([{
business_id,
learner_id,
match_score,
reason
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating verification API..."

cat > api/business-verification.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="POST"){

const {data,error}=await db
.from("business_verification_requests")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

}


const {data,error}=await db
.from("business_verification_requests")
.select("*");


return res.json({
data,
error
});

};
JS



echo "Creating dashboard log API..."

cat > api/business-log.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("business_dashboard_logs")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



git add database/business_ai_verification_upgrade.sql api/business-dashboard.js api/business-register.js api/ai-match.js api/business-verification.js api/business-log.js

git commit -m "Add business dashboard AI matching and verification system" || true

git push


echo "======================================"
echo " Business AI Upgrade Complete"
echo "======================================"

echo "Run SQL:"
echo "database/business_ai_verification_upgrade.sql"

