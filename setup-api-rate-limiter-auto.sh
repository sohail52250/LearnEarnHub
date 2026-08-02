#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub API Rate Limiter Setup ==="


mkdir -p middleware


cat > middleware/api-rate-limiter.js <<'JS'
const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async function(req,res,next){


try{


const key=req.headers["x-api-key"];


if(!key){

return res.status(401).json({

error:"Missing API Key"

});

}



const result=await db

.from("api_partner_keys")

.select("*")

.eq("api_key",key)

.single();



if(result.error || !result.data){

return res.status(401).json({

error:"Invalid API Key"

});

}



const api=result.data;



if(api.blocked || api.status!=="active"){

return res.status(403).json({

error:"API Key Disabled"

});

}



await db

.from("api_partner_keys")

.update({

last_used_at:new Date()

})

.eq("id",api.id);



next();



}catch(e){

res.status(500).json({

error:e.message

});

}


};
JS



cat > database/api-rate-limiter.sql <<'SQL'


-- =====================================
-- API Usage Tracking
-- =====================================


create table if not exists public.api_usage_logs
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key_id bigint
references public.api_partner_keys(id)
on delete cascade,

endpoint text,

method text,

status_code integer,

created_at timestamptz default now()

);



create index if not exists idx_api_usage_partner

on public.api_usage_logs(partner_id);



create index if not exists idx_api_usage_key

on public.api_usage_logs(api_key_id);



notify pgrst,'reload schema';



select *

from public.api_usage_logs;


SQL



git add .

git commit -m "Add API rate limiter and usage tracking"


echo ""
echo "DONE"
echo ""
echo "SQL:"
echo "database/api-rate-limiter.sql"

