#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment Governance V9"
echo "======================================"

mkdir -p database


cat > database/investment-governance-v9.sql <<'SQL'

CREATE TABLE IF NOT EXISTS investor_approvals (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

reviewer_id uuid,

status text DEFAULT 'pending',

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS funding_agreements (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

agreement_title text,

agreement_content text,

signed_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS shareholder_records (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

investor_id uuid,

ownership_percentage numeric DEFAULT 0,

share_type text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_documents (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

document_name text,

document_url text,

verification_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS governance_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-governance.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const investment_id=req.query.investment_id;


const approvals=await db
.from("investor_approvals")
.select("*")
.eq("investment_id",investment_id);


const agreements=await db
.from("funding_agreements")
.select("*")
.eq("investment_id",investment_id);


const documents=await db
.from("investment_documents")
.select("*")
.eq("investment_id",investment_id);


return res.json({

success:true,

approvals:approvals.data||[],

agreements:agreements.data||[],

documents:documents.data||[]

});

}


if(req.method==="POST"){


const {data,error}=await db

.from("governance_logs")

.insert([req.body])

.select();


return res.json({

success:!error,

data,

error

});


}


res.status(405).json({

error:"Method not allowed"

});


};
JS



cat > public/investment-governance.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment Governance Center</title>

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


<h1>🏛 Investment Governance Center</h1>


<div class="card">

<h2>Investor Approval</h2>

<p id="approval">
Loading...
</p>

</div>


<div class="card">

<h2>Funding Agreements</h2>

<p id="agreements">
Loading...
</p>

</div>


<div class="card">

<h2>Investment Documents</h2>

<p id="documents">
Loading...
</p>

</div>


<script>

let investment_id=
new URLSearchParams(location.search)
.get("investment_id");


fetch(
"/api/investment-governance?investment_id="+investment_id
)

.then(r=>r.json())

.then(d=>{

approval.innerHTML=
JSON.stringify(d.approvals||[]);

agreements.innerHTML=
JSON.stringify(d.agreements||[]);

documents.innerHTML=
JSON.stringify(d.documents||[]);

});

</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment Governance V9" || true

git push


echo "======================================"
echo " Investment Governance V9 Completed"
echo "======================================"

