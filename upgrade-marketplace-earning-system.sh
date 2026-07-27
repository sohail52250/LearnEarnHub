#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Marketplace Upgrade"
echo "======================================"

mkdir -p database


cat > database/marketplace_earning_upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS earning_tasks (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
title_en text,
title_ur text,
description_en text,
description_ur text,
reward integer DEFAULT 0,
status text DEFAULT 'active',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS task_applications (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
task_id uuid REFERENCES earning_tasks(id),
user_id uuid REFERENCES users(id),
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_opportunities (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
title_en text,
title_ur text,
description_en text,
description_ur text,
category text,
status text DEFAULT 'open',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS business_offers (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
business_id uuid,
offer_title text,
offer_description text,
category text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS opportunity_matches (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
learner_id uuid,
opportunity_id uuid,
match_score integer DEFAULT 0,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS payment_transactions (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
amount integer DEFAULT 0,
payment_type text,
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);

SQL



echo "Creating earning tasks API..."

cat > api/earning-tasks.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const {data,error}=await db
.from("earning_tasks")
.select("*")
.order("created_at",{ascending:false});

return res.json({data,error});

}


if(req.method==="POST"){

const {data,error}=await db
.from("earning_tasks")
.insert([req.body])
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



echo "Creating applications API..."

cat > api/task-application.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {task_id,user_id}=req.body;


const {data,error}=await db
.from("task_applications")
.insert([{
task_id,
user_id
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating opportunity matching API..."

cat > api/opportunity-match.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {
learner_id,
opportunity_id,
match_score
}=req.body;


const {data,error}=await db
.from("opportunity_matches")
.insert([{
learner_id,
opportunity_id,
match_score
}])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating payment API..."

cat > api/payment-transaction.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("payment_transactions")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



git add database/marketplace_earning_upgrade.sql api/earning-tasks.js api/task-application.js api/opportunity-match.js api/payment-transaction.js

git commit -m "Add marketplace earning tasks and matching system" || true

git push


echo "======================================"
echo " Marketplace Upgrade Complete"
echo "======================================"

echo "Run SQL in Supabase:"
echo "database/marketplace_earning_upgrade.sql"

