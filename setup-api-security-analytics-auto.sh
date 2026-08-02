#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub API Security Analytics Setup ==="

mkdir -p api/developer
mkdir -p public/partner
mkdir -p database


cat > database/api-security-analytics.sql <<'SQL'

-- =====================================================
-- LearnEarnHub API Security + Analytics
-- =====================================================


-- API SECURITY EVENTS

create table if not exists public.api_security_events
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key_id bigint
references public.api_partner_keys(id)
on delete cascade,

event_type text not null,

details jsonb default '{}'::jsonb,

created_at timestamptz default now()

);



create index if not exists idx_api_security_partner

on public.api_security_events(partner_id);



create index if not exists idx_api_security_key

on public.api_security_events(api_key_id);



-- API ANALYTICS VIEW

create or replace view public.api_security_analytics as

select

k.id as api_key_id,

k.partner_id,

p.partner_name,

k.api_key,

k.status,

k.blocked,

k.request_limit,

k.monthly_limit,

count(e.id) as security_events,


max(e.created_at) as last_security_event


from public.api_partner_keys k


left join public.api_partners p

on p.id=k.partner_id


left join public.api_security_events e

on e.api_key_id=k.id


group by

k.id,

k.partner_id,

p.partner_name,

k.api_key,

k.status,

k.blocked,

k.request_limit,

k.monthly_limit;



-- DEMO SECURITY EVENT

insert into public.api_security_events
(
partner_id,
api_key_id,
event_type,
details
)

select

k.partner_id,

k.id,

'API_KEY_CREATED',

jsonb_build_object(
'action',
'Initial API key setup'
)

from public.api_partner_keys k

where k.api_key='LEH_PUBLIC_API_DEMO_KEY_2026';



notify pgrst,'reload schema';


select *
from public.api_security_analytics;

SQL



cat > api/developer/security.js <<'JS'

const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async(req,res)=>{

try{

const data =
await db
.from("api_security_analytics")
.select("*");


res.json({

success:true,

security:data.data || []

});


}

catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



python3 - <<'PY'

p="server.js"

s=open(p).read()

if "/api/developer/security" not in s:

 s=s.replace(
 "module.exports = app;",
 """

const developerSecurity =
require("./api/developer/security");

app.get(
"/api/developer/security",
developerSecurity
);


module.exports = app;
"""
 )

 open(p,"w").write(s)

PY



cat > public/partner/security.html <<'HTML'

<!DOCTYPE html>

<html>

<head>

<title>
LearnEarnHub API Security
</title>

</head>

<body>

<h1>
API Security Analytics
</h1>


<pre id="data">
Loading...
</pre>


<script>

fetch("/api/developer/security")

.then(r=>r.json())

.then(d=>{

document.getElementById("data")
.textContent=
JSON.stringify(d,null,2);

});

</script>


</body>

</html>

HTML



git add .

git commit -m "Add API security analytics dashboard"


echo ""
echo "DONE"
echo ""
echo "Run SQL:"
echo "database/api-security-analytics.sql"
echo ""
echo "Deploy:"
echo "vercel --prod"

