#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment Marketplace V10"
echo "======================================"

mkdir -p database


cat > database/investment-marketplace-v10.sql <<'SQL'

CREATE TABLE IF NOT EXISTS funding_rounds (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

round_name text,

target_amount numeric DEFAULT 0,

raised_amount numeric DEFAULT 0,

status text DEFAULT 'open',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_offers (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

round_id uuid,

investor_id uuid,

offer_amount numeric DEFAULT 0,

terms text,

status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_closing_checklist (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

round_id uuid,

item text,

status text DEFAULT 'pending',

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS marketplace_activity (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-marketplace.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const rounds=await db
.from("funding_rounds")
.select("*")
.order("created_at",{ascending:false});


return res.json({

success:true,

rounds:rounds.data||[]

});

}



if(req.method==="POST"){


const {data,error}=await db

.from("investment_offers")

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



cat > public/investment-marketplace.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment Marketplace</title>

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


<h1>💼 Investment Marketplace</h1>


<div id="rounds">
Loading...
</div>


<script>

fetch("/api/investment-marketplace")

.then(r=>r.json())

.then(d=>{


rounds.innerHTML=(d.rounds||[])

.map(r=>`

<div class="card">

<h3>
${r.round_name}
</h3>

<p>
Target: ${r.target_amount}
</p>

<p>
Raised: ${r.raised_amount}
</p>

<p>
Status: ${r.status}
</p>

</div>

`)

.join("");

});

</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment Marketplace V10" || true

git push


echo "======================================"
echo " Investment Marketplace V10 Completed"
echo "======================================"

