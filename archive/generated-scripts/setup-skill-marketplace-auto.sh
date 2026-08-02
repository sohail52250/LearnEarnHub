#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Skill Marketplace Connection ==="

mkdir -p services api public



cat > database/skill-marketplace.sql <<'SQL'

CREATE TABLE IF NOT EXISTS marketplace_opportunities (

id BIGSERIAL PRIMARY KEY,

title TEXT NOT NULL,

description TEXT,

required_skill TEXT NOT NULL,

type TEXT DEFAULT 'task',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS learner_applications (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES marketplace_opportunities(id) ON DELETE CASCADE,

status TEXT DEFAULT 'pending',

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(user_id,opportunity_id)

);



CREATE INDEX IF NOT EXISTS opportunity_skill_idx

ON marketplace_opportunities(required_skill);


SQL



cat > services/marketplace-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getAvailableJobs(user_id){


const {data:skills}=await db
.from("learner_skills")
.select("skill_name")
.eq("user_id",user_id)
.eq("verified",true);



if(!skills || !skills.length)
return [];



const names=
skills.map(s=>s.skill_name);



const {data,error}=await db
.from("marketplace_opportunities")
.select("*")
.in("required_skill",names);



if(error) throw error;


return data || [];

}



async function applyJob(user_id,opportunity_id){


const {data,error}=await db
.from("learner_applications")
.insert({

user_id,

opportunity_id

})
.select()
.single();



if(error) throw error;


return data;

}



module.exports={
getAvailableJobs,
applyJob
};

JS



cat > api/marketplace-jobs.js <<'JS'
const service=require("../services/marketplace-service");


module.exports=async function(req,res){

try{


if(req.query.user_id){

return res.json(
await service.getAvailableJobs(
req.query.user_id
)
);

}



if(req.body.action==="apply"){

return res.json(
await service.applyJob(
req.body.user_id,
req.body.opportunity_id
)
);

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



if ! grep -q "/api/marketplace-jobs" server.js
then

cat >> server.js <<'JS'


// Skill Marketplace API

const marketplaceJobs=require("./api/marketplace-jobs");


app.get(
"/api/marketplace-jobs",
marketplaceJobs
);


app.post(
"/api/marketplace-jobs",
marketplaceJobs
);


JS

fi



cat > public/jobs.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Skill Jobs</title>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.card{

background:white;
padding:15px;
margin:10px;
border-radius:12px;

}

button{

background:#1565c0;
color:white;
border:0;
padding:10px;

}

</style>

</head>


<body>


<h1>💼 Available Opportunities</h1>


<div id="jobs">
Loading...
</div>



<script>


const user_id=
new URLSearchParams(location.search)
.get("user_id");



async function load(){


let r=
await fetch(
"/api/marketplace-jobs?user_id="+user_id
);


let jobs=
await r.json();



document.getElementById("jobs")
.innerHTML=
jobs.map(j=>`

<div class="card">

<h3>${j.title}</h3>

<p>${j.description || ""}</p>

<p>
Skill:
${j.required_skill}
</p>


<button onclick="apply(${j.id})">
Apply
</button>


</div>

`).join("");

}



async function apply(id){

await fetch(
"/api/marketplace-jobs",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"apply",

user_id,

opportunity_id:id

})

});


alert("Application sent ✅");

}



load();


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Skill marketplace connection created"

echo ""
echo "Flow:"
echo "Certificate"
echo " ↓"
echo "Verified Skill"
echo " ↓"
echo "Matching Jobs"
echo " ↓"
echo "Apply & Earn"


