#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise Contract & Procurement V21"
echo "======================================"

mkdir -p database


cat > database/enterprise-procurement-v21.sql <<'SQL'

CREATE TABLE IF NOT EXISTS vendor_profiles (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

company_id uuid,

vendor_name text,

category text,

country text,

approval_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS purchase_requests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

vendor_id uuid,

request_title text,

amount numeric DEFAULT 0,

purpose text,

status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_contract_workflow (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

vendor_id uuid,

contract_title text,

contract_status text DEFAULT 'draft',

approval_stage text DEFAULT 'review',

contract_details text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS procurement_tracking (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

request_id uuid,

stage text,

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS procurement_activity_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

organization_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/enterprise-procurement.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


const organization_id=req.query.organization_id;


const vendors=await db
.from("vendor_profiles")
.select("*")
.order("created_at",{ascending:false});


const requests=await db
.from("purchase_requests")
.select("*")
.eq("organization_id",organization_id);


const contracts=await db
.from("enterprise_contract_workflow")
.select("*")
.eq("organization_id",organization_id);


res.json({

success:true,

vendors:vendors.data||[],

purchase_requests:requests.data||[],

contracts:contracts.data||[]

});


};
JS



cat > public/enterprise-procurement.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Procurement Center</title>

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


<h1>📑 Enterprise Contract & Procurement Center</h1>


<div class="card">

<h2>Approved Vendors</h2>

<pre id="vendors">
Loading...
</pre>

</div>


<div class="card">

<h2>Purchase Requests</h2>

<pre id="requests">
Loading...
</pre>

</div>


<div class="card">

<h2>Contracts</h2>

<pre id="contracts">
Loading...
</pre>

</div>



<script>

let organization_id =
new URLSearchParams(location.search)
.get("organization_id");


fetch(
"/api/enterprise-procurement?organization_id="+organization_id
)

.then(r=>r.json())

.then(d=>{


vendors.innerHTML=
JSON.stringify(d.vendors,null,2);


requests.innerHTML=
JSON.stringify(d.purchase_requests,null,2);


contracts.innerHTML=
JSON.stringify(d.contracts,null,2);


});

</script>


</body>

</html>
HTML



git add .

git commit -m "Add Enterprise Contract Procurement System V21" || true

git push


echo "======================================"
echo " Enterprise Procurement V21 Completed"
echo "======================================"

