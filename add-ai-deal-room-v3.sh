#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " AI Deal Room Integration V3"
echo "======================================"


cat > database/ai-deal-room-v3.sql <<'SQL'

CREATE TABLE IF NOT EXISTS ai_deal_rooms (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

owner_id uuid,

ai_summary text,

valuation_notes text,

risk_analysis text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_negotiations (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

user_id uuid,

message text,

stage text DEFAULT 'negotiation',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_due_diligence (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

deal_id uuid,

item text,

status text DEFAULT 'pending',

notes text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/ai-deal-room.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const deal_id=req.query.deal_id;


const room=await db
.from("ai_deal_rooms")
.select("*")
.eq("deal_id",deal_id);


const checks=await db
.from("deal_due_diligence")
.select("*")
.eq("deal_id",deal_id);


const negotiations=await db
.from("deal_negotiations")
.select("*")
.eq("deal_id",deal_id);


return res.json({

success:true,

room:room.data||[],

due_diligence:checks.data||[],

negotiations:negotiations.data||[]

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("ai_deal_rooms")

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



cat > public/ai-deal-room.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>AI Deal Room</title>

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


<h1>🤖 AI Deal Room</h1>


<div class="card">

<h2>
Deal Intelligence
</h2>

<div id="summary">
Loading...
</div>

</div>


<div class="card">

<h2>
Due Diligence
</h2>

<div id="checks">
Loading...
</div>

</div>



<div class="card">

<h2>
Negotiations
</h2>

<div id="messages">
Loading...
</div>

</div>



<script>


let deal_id=
new URLSearchParams(location.search)
.get("deal_id");


fetch("/api/ai-deal-room?deal_id="+deal_id)

.then(r=>r.json())

.then(d=>{


summary.innerHTML=
JSON.stringify(d.room||[]);


checks.innerHTML=
JSON.stringify(d.due_diligence||[]);


messages.innerHTML=
JSON.stringify(d.negotiations||[]);


});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add AI Deal Room integration V3" || true

git push


echo "======================================"
echo " AI Deal Room Added"
echo "======================================"

