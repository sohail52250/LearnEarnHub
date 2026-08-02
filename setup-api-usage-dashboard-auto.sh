#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub API Usage Dashboard Setup ==="


mkdir -p public/partner
mkdir -p api/developer
mkdir -p database


# SQL FILE

cat > database/api-usage-dashboard.sql <<'SQL'

-- =====================================================
-- LearnEarnHub API Usage Dashboard
-- =====================================================


create table if not exists public.api_request_events
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key_id bigint
references public.api_partner_keys(id)
on delete cascade,

endpoint text,

method text default 'GET',

status_code integer,

created_at timestamptz default now()

);



create index if not exists idx_api_events_partner
on public.api_request_events(partner_id);



create index if not exists idx_api_events_key
on public.api_request_events(api_key_id);



create index if not exists idx_api_events_date
on public.api_request_events(created_at);



create or replace view public.api_usage_dashboard as

select

k.id as api_key_id,

k.partner_id,

k.api_key,

k.status,

k.request_limit,

k.monthly_limit,

count(e.id) as total_requests,

max(e.created_at) as last_request


from public.api_partner_keys k

left join public.api_request_events e

on k.id=e.api_key_id


group by

k.id,

k.partner_id,

k.api_key,

k.status,

k.request_limit,

k.monthly_limit;



notify pgrst,'reload schema';



select *

from public.api_usage_dashboard;

SQL



# API ROUTE

cat > api/developer/usage.js <<'JS'

const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async(req,res)=>{


try{


const data=await db

.from("api_usage_dashboard")

.select("*");



res.json({

success:true,

usage:data.data || []

});


}

catch(e){

res.status(500).json({

error:e.message

});

}


};

JS



# Add route

python3 - <<'PY'

p="server.js"

s=open(p).read()

if "/api/developer/usage" not in s:

    s=s.replace(
    "module.exports = app;",
    """

const developerUsage =
require("./api/developer/usage");

app.get(
"/api/developer/usage",
developerUsage
);


module.exports = app;
"""
    )

    open(p,"w").write(s)

PY



# Dashboard page

cat > public/partner/usage.html <<'HTML'

<!DOCTYPE html>

<html>

<head>

<title>
LearnEarnHub API Usage Dashboard
</title>

<style>

body{
font-family:Arial;
padding:30px;
background:#f4f4f4;
}

.card{
background:white;
padding:20px;
border-radius:12px;
}

</style>

</head>


<body>


<h1>
API Usage Analytics
</h1>


<div class="card">

<pre id="usage">
Loading...
</pre>

</div>



<script>

fetch("/api/developer/usage")

.then(r=>r.json())

.then(d=>{

document.getElementById("usage")
.textContent=
JSON.stringify(d,null,2);

});


</script>


</body>

</html>

HTML



git add .

git commit -m "Add API usage analytics dashboard"



echo ""
echo "DONE"
echo ""
echo "Run SQL:"
echo "database/api-usage-dashboard.sql"
echo ""
echo "Deploy:"
echo "vercel --prod"

