#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub API Partner Dashboard Setup ==="

mkdir -p public/api-partner
mkdir -p api/api-partner


cat > public/api-partner/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>API Partner Dashboard - LearnEarnHub</title>
<meta charset="UTF-8">
<style>
body{font-family:Arial;margin:30px}
.card{border:1px solid #ddd;padding:20px;border-radius:12px}
button{padding:10px 20px}
</style>
</head>

<body>

<h1>LearnEarnHub API Partner Center</h1>

<div class="card">

<h2>Request API Access</h2>

<form id="form">

<input id="company" placeholder="Company Name"><br><br>

<input id="email" placeholder="Email"><br><br>

<textarea id="purpose"
placeholder="Integration purpose"></textarea>

<br><br>

<button>
Submit Request
</button>

</form>

<p id="result"></p>

</div>


<script>

document.querySelector("#form")
.addEventListener("submit",async(e)=>{

e.preventDefault();

let r=await fetch("/api/api-partner/request",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

company_name:
company.value,

email:
email.value,

purpose:
purpose.value

})

});


let data=await r.json();

result.innerHTML=
JSON.stringify(data);

});


</script>


</body>
</html>
HTML



cat > api/api-partner/request.js <<'JS'

const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async(req,res)=>{


if(req.method!=="POST")
return res.status(405).json({
error:"POST required"
});


try{


const {company_name,email,purpose}=req.body;


let result=await db
.from("api_join_requests")
.insert({

company_name,
email,
purpose,
status:"pending"

})
.select();


res.json({

success:true,

message:
"API partnership request submitted",

data:
result.data

});


}catch(e){

res.status(500).json({
error:e.message
});

}


};

JS



cat > database/api-partner-dashboard.sql <<'SQL'


-- API KEY MANAGEMENT

create table if not exists public.api_partner_keys
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

api_key text unique not null,

status text default 'active',

created_at timestamptz default now()

);



-- API APPROVAL LOG

create table if not exists public.api_approval_logs
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

action text,

approved_by text,

created_at timestamptz default now()

);



-- DEMO KEY

insert into public.api_partner_keys
(
partner_id,
api_key
)

select

id,

'LEH_PUBLIC_API_DEMO_KEY_2026'

from public.api_partners

where email='partner@learn-earnhub.com'

on conflict(api_key)
do nothing;



notify pgrst,'reload schema';


select *
from public.api_partner_keys;

SQL



git add .

git commit -m "Add API partner dashboard and key management"


echo ""
echo "DONE"
echo ""
echo "Open:"
echo "https://learn-earnhub.vercel.app/api-partner/"
echo ""
echo "Run SQL:"
echo "database/api-partner-dashboard.sql"


