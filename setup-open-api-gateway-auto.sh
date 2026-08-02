#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Open API Gateway Setup ==="


mkdir -p middleware api/partner logs



cat > database/open-api-gateway.sql <<'SQL'

-- =========================================
-- Open API Partner System
-- =========================================


create table if not exists public.api_partners (

id bigint generated always as identity primary key,

name text not null,

email text,

api_key text unique not null,

status text default 'active',

rate_limit integer default 1000,

created_at timestamptz default now()

);



create table if not exists public.api_request_logs (

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

endpoint text,

method text,

created_at timestamptz default now()

);



create index if not exists idx_api_logs_partner

on public.api_request_logs(partner_id);



notify pgrst,'reload schema';

SQL



cat > middleware/api-key-auth.js <<'JS'

const crypto=require("crypto");

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async function(req,res,next){


const key=req.headers["x-api-key"];



if(!key){

return res.status(401).json({

error:"API key required"

});

}



const {data,error}=await db

.from("api_partners")

.select("*")

.eq("api_key",key)

.eq("status","active")

.single();



if(error || !data){

return res.status(403).json({

error:"Invalid API key"

});

}



await db

.from("api_request_logs")

.insert({

partner_id:data.id,

endpoint:req.path,

method:req.method

});



req.partner=data;


next();


};

JS



cat > api/partner/jobs.js <<'JS'

const express=require("express");

const router=express.Router();

const auth=require("../../middleware/api-key-auth");


router.get(
"/",
auth,
async(req,res)=>{


const {createClient}=require("@supabase/supabase-js");


const db=createClient(

process.env.SUPABASE_URL,

process.env.SUPABASE_SERVICE_KEY

);



const {data}=await db

.from("imported_jobs")

.select("*")

.eq("status","active")

.limit(100);



res.json({

partner:req.partner.name,

count:data.length,

jobs:data

});


});


module.exports=router;

JS



node -c middleware/api-key-auth.js

node -c api/partner/jobs.js



echo ""
echo "Created:"
echo "database/open-api-gateway.sql"
echo "middleware/api-key-auth.js"
echo "api/partner/jobs.js"

echo ""
echo "=== Open API Gateway Ready ==="

