#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Earnings Tracker Setup ==="

mkdir -p services api public



cat > database/earnings.sql <<'SQL'

CREATE TABLE IF NOT EXISTS learner_earnings (

id BIGSERIAL PRIMARY KEY,

learner_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

amount NUMERIC DEFAULT 0,

currency TEXT DEFAULT 'USD',

status TEXT DEFAULT 'pending',

paid_at TIMESTAMP DEFAULT NULL,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS business_payments (

id BIGSERIAL PRIMARY KEY,

business_id BIGINT,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

amount NUMERIC DEFAULT 0,

currency TEXT DEFAULT 'USD',

status TEXT DEFAULT 'pending',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS earnings_user_idx

ON learner_earnings(learner_id);


SQL



cat > services/earning-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function addEarning(data){


const {data:result,error}=await db
.from("learner_earnings")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function getEarnings(learner_id){


const {data,error}=await db
.from("learner_earnings")
.select("*")
.eq("learner_id",learner_id);



if(error) throw error;


return data || [];

}



async function totalEarned(learner_id){


const rows=await getEarnings(learner_id);


return rows.reduce(
(sum,x)=>sum+Number(x.amount),
0
);


}



module.exports={

addEarning,

getEarnings,

totalEarned

};

JS



cat > api/earnings.js <<'JS'
const service=require("../services/earning-service");


module.exports=async function(req,res){

try{


if(req.body.action==="add"){

return res.json(
await service.addEarning(
req.body.data
)
);

}



if(req.query.learner_id){

return res.json({

records:
await service.getEarnings(
req.query.learner_id
),

total:
await service.totalEarned(
req.query.learner_id
)

});

}



res.status(400).json({
error:"Invalid request"
});



}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/earnings" server.js
then

cat >> server.js <<'JS'


// Earnings API

const earnings=require("./api/earnings");


app.get(
"/api/earnings",
earnings
);


app.post(
"/api/earnings",
earnings
);


JS

fi



cat > public/earnings.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>My Earnings</title>

<style>

body{

font-family:Arial;

background:#f5f7fb;

padding:20px;

}

.card{

background:white;

padding:20px;

border-radius:12px;

}

</style>

</head>


<body>


<h1>💰 My Earnings</h1>


<div class="card" id="box">
Loading...
</div>



<script>


const learner_id=
new URLSearchParams(location.search)
.get("learner_id");



async function load(){


let r=
await fetch(
"/api/earnings?learner_id="+learner_id
);


let d=
await r.json();



box.innerHTML=

`
<h2>Total Earned: ${d.total || 0}</h2>
<p>
Completed records:
${d.records?.length || 0}
</p>
`;

}


load();


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Earnings tracker created"

echo ""
echo "Flow:"
echo "Completed job"
echo " ↓"
echo "Add earning"
echo " ↓"
echo "Learner earnings dashboard"


