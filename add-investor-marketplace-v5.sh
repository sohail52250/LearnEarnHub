#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investor Marketplace & Funding V5"
echo "======================================"


cat > database/investor-marketplace-v5.sql <<'SQL'

CREATE TABLE IF NOT EXISTS investor_profiles (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

investor_type text,

industry_focus text,

investment_range numeric DEFAULT 0,

location text,

bio text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS funding_requests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

owner_id uuid,

funding_amount numeric DEFAULT 0,

purpose text,

equity_offered text,

status text DEFAULT 'open',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_interests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

funding_id uuid,

investor_id uuid,

message text,

status text DEFAULT 'submitted',

created_at timestamp DEFAULT now()

);

SQL



cat > api/investor-marketplace.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const requests=await db

.from("funding_requests")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

funding_requests:requests.data||[]

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("funding_requests")

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



cat > api/investment-interest.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="POST"){


const {data,error}=await db

.from("investment_interests")

.insert([req.body])

.select();



return res.json({

success:!error,

data,

error

});


}


};
JS



cat > public/investor-marketplace.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investor Marketplace</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:12px;
}

</style>

</head>


<body>


<h1>💰 Investor Marketplace</h1>


<div class="card">

<h2>
Create Funding Request
</h2>


<input id="business_id" placeholder="Business ID">

<input id="funding_amount" placeholder="Funding Amount">


<textarea id="purpose"
placeholder="Funding Purpose"></textarea>


<input id="equity_offered"
placeholder="Equity Offered">


<button onclick="createFunding()">
Submit Request
</button>


</div>



<h2>
Open Opportunities
</h2>


<div id="list">
Loading...
</div>



<script>


async function load(){


let r=await fetch("/api/investor-marketplace");

let d=await r.json();


list.innerHTML=(d.funding_requests||[])

.map(x=>`

<div class="card">

<h3>
Funding Required: ${x.funding_amount}
</h3>

<p>
${x.purpose||""}
</p>

<p>
Status: ${x.status}
</p>

</div>

`)

.join("");

}



async function createFunding(){


await fetch("/api/investor-marketplace",{

method:"POST",

headers:{

"Content-Type":"application/json"

},

body:JSON.stringify({

business_id:business_id.value,

funding_amount:funding_amount.value,

purpose:purpose.value,

equity_offered:equity_offered.value

})

});


alert("Funding request created");

load();

}


load();

</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investor Marketplace and Funding Module V5" || true

git push


echo "======================================"
echo " Investor Marketplace Added"
echo "======================================"

