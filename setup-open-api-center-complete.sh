#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Open API Center Setup ==="

mkdir -p public/api-center
mkdir -p api/partners

cat > public/api-center/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Open API Center</title>
<meta charset="UTF-8">
<style>
body{font-family:Arial;margin:40px;line-height:1.6}
.card{border:1px solid #ddd;padding:20px;border-radius:10px}
</style>
</head>

<body>

<h1>LearnEarnHub Open API Center</h1>

<div class="card">

<h2>Secure Data Sharing Partnership</h2>

<p>
LearnEarnHub provides controlled API access for approved partners.
The system follows a give-and-take sharing model.
</p>

<ul>
<li>Jobs and opportunities sharing</li>
<li>Learner opportunity matching</li>
<li>Partner integrations</li>
<li>API key security</li>
<li>Usage limits</li>
<li>Misuse prevention</li>
</ul>


<h2>API Access Process</h2>

<ol>
<li>Submit partnership request</li>
<li>Verification by LearnEarnHub</li>
<li>API key generation</li>
<li>Limited access activation</li>
</ol>


<h2>Available APIs</h2>

<ul>
<li>/api/global-opportunities</li>
<li>/api/employer-posts</li>
<li>/api/recommendations</li>
<li>/api/notifications</li>
</ul>


</div>

</body>
</html>
HTML


cat > api/partners/request.js <<'JS'
const db=require("../../database");

module.exports=async(req,res)=>{

if(req.method!=="POST"){
return res.status(405).json({error:"POST required"});
}

try{

const {company_name,email,purpose}=req.body;

const result=await db
.from("api_join_requests")
.insert({
company_name,
email,
purpose
})
.select();

res.json({
success:true,
request:result.data
});

}catch(e){

res.status(500).json({
error:e.message
});

}

};
JS


echo "Creating SQL file..."

cat > database/open-api-center.sql <<'SQL'

-- ======================================
-- LearnEarnHub Open API Center Database
-- ======================================


create table if not exists public.api_join_requests
(
id bigint generated always as identity primary key,

company_name text not null,

email text not null,

purpose text,

status text default 'pending',

created_at timestamptz default now(),

updated_at timestamptz default now()
);



create table if not exists public.api_permissions
(
id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

permission_name text not null,

allowed boolean default false,

created_at timestamptz default now()
);



create table if not exists public.api_rate_limits
(
id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

daily_limit integer default 1000,

monthly_limit integer default 30000,

created_at timestamptz default now()
);



create table if not exists public.api_agreements
(
id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

agreement_type text default 'data-sharing',

accepted boolean default false,

accepted_at timestamptz,

created_at timestamptz default now()
);



notify pgrst,'reload schema';


select *
from public.api_join_requests;

SQL


git add .

git commit -m "Add LearnEarnHub Open API Center foundation"


echo ""
echo "DONE"
echo "Terminal setup completed"
echo "Run SQL:"
echo "database/open-api-center.sql"

