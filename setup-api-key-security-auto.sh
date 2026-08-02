#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub API Security Layer ==="


mkdir -p middleware
mkdir -p api/api-partner


cat > middleware/api-key-auth.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports = async function(req,res,next){

try{

const key =
req.headers["x-api-key"] ||
req.query.api_key;


if(!key){

return res.status(401).json({
error:"API key required"
});

}


const {data,error}=await db
.from("api_partner_keys")
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
.from("api_partner_keys")
.update({
last_used_at:new Date()
})
.eq("id",data.id);



req.apiPartner=data;

next();


}catch(e){

res.status(500).json({
error:e.message
});

}

};
JS



cat > api/api-partner/test.js <<'JS'

const auth=require("../../middleware/api-key-auth");


module.exports=[
auth,
(req,res)=>{

res.json({

success:true,

message:"LearnEarnHub API authentication active",

partner:req.apiPartner.partner_id

});

}

];

JS



cat > database/api-security-layer.sql <<'SQL'


-- =====================================
-- API SECURITY SUPPORT
-- =====================================


alter table public.api_partner_keys

add column if not exists

request_limit integer default 1000;



alter table public.api_partner_keys

add column if not exists

monthly_limit integer default 30000;



alter table public.api_partner_keys

add column if not exists

blocked boolean default false;



create table if not exists public.api_security_events
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

event_type text,

details jsonb,

created_at timestamptz default now()

);



notify pgrst,'reload schema';



select *
from public.api_partner_keys;


SQL



git add .

git commit -m "Add API key authentication security layer"


echo ""
echo "DONE"
echo ""
echo "SQL:"
echo "database/api-security-layer.sql"

