#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise Investor Portal V17"
echo "======================================"

mkdir -p database


cat > database/enterprise-investor-portal-v17.sql <<'SQL'

CREATE TABLE IF NOT EXISTS investor_organizations (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

name text,

industry text,

country text,

description text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS organization_members (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

user_id uuid,

role text DEFAULT 'member',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_deal_rooms (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

deal_id uuid,

access_level text DEFAULT 'private',

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

report_type text,

report_data text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_activity_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

user_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/enterprise-investor-portal.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


const organization_id=req.query.organization_id;


const members=await db
.from("organization_members")
.select("*")
.eq("organization_id",organization_id);


const rooms=await db
.from("enterprise_deal_rooms")
.select("*")
.eq("organization_id",organization_id);


const reports=await db
.from("enterprise_reports")
.select("*")
.eq("organization_id",organization_id);


res.json({

success:true,

members:members.data||[],

deal_rooms:rooms.data||[],

reports:reports.data||[]

});


};
JS



cat > public/enterprise-investor-portal.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Investor Portal</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:20px;
margin:10px;
border-radius:12px;
}

</style>

</head>


<body>


<h1>🏢 Enterprise Investor Portal</h1>


<div class="card">

<h2>
Team Members
</h2>

<pre id="members">
Loading...
</pre>

</div>


<div class="card">

<h2>
Private Deal Rooms
</h2>

<pre id="rooms">
Loading...
</pre>

</div>


<div class="card">

<h2>
Enterprise Reports
</h2>

<pre id="reports">
Loading...
</pre>

</div>



<script>


let organization_id =
new URLSearchParams(location.search)
.get("organization_id");


fetch(
"/api/enterprise-investor-portal?organization_id="+organization_id
)

.then(r=>r.json())

.then(d=>{


members.innerHTML=
JSON.stringify(d.members,null,2);


rooms.innerHTML=
JSON.stringify(d.deal_rooms,null,2);


reports.innerHTML=
JSON.stringify(d.reports,null,2);


});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add Enterprise Investor Portal V17" || true

git push


echo "======================================"
echo " Enterprise Investor Portal V17 Completed"
echo "======================================"

