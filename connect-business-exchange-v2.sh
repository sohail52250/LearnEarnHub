#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Business Exchange Connected V2"
echo "======================================"


cat > database/business-exchange-v2.sql <<'SQL'

CREATE TABLE IF NOT EXISTS business_deals (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

owner_id uuid,

deal_type text,

title text,

description text,

value numeric DEFAULT 0,

status text DEFAULT 'draft',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_messages (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

sender_id uuid,

message text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/business-exchange.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const {data,error}=await db

.from("business_deals")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

deals:data||[],

error

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("business_deals")

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



cat > public/business-exchange-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Business Exchange Dashboard</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:12px;
}

button{
padding:10px;
}

</style>

</head>


<body>


<h1>🏢 Business Exchange Dashboard</h1>


<div class="card">

<h2>Create Deal</h2>


<select id="type">

<option>Sell Business</option>

<option>Buy Business</option>

<option>Acquisition</option>

<option>Merger</option>

<option>Partnership</option>

</select>


<input id="title" placeholder="Deal Title">


<textarea id="description"
placeholder="Description"></textarea>


<button onclick="createDeal()">
Create Deal
</button>


</div>



<h2>Available Deals</h2>

<div id="deals">
Loading...
</div>



<script>


async function loadDeals(){

let r=await fetch("/api/business-exchange");

let d=await r.json();


deals.innerHTML=(d.deals||[])

.map(x=>`

<div class="card">

<h3>${x.title}</h3>

<p>${x.deal_type}</p>

<p>Status: ${x.status}</p>

<p>${x.description||""}</p>

</div>

`)

.join("");

}


async function createDeal(){


await fetch("/api/business-exchange",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

deal_type:type.value,

title:title.value,

description:description.value,

status:"draft"

})

});


alert("Deal created");

loadDeals();

}


loadDeals();

</script>


</body>

</html>
HTML



git add .

git commit -m "Connect Business Exchange Dashboard with deal system" || true

git push


echo "======================================"
echo " Business Exchange V2 Completed"
echo "======================================"

