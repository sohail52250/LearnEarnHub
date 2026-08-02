#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Employer Marketplace Setup ==="

mkdir -p services api public/business



cat > database/employer-marketplace.sql <<'SQL'

CREATE TABLE IF NOT EXISTS business_profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL UNIQUE,

company_name TEXT,

description TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS business_opportunities (

id BIGSERIAL PRIMARY KEY,

business_id BIGINT REFERENCES business_profiles(id) ON DELETE CASCADE,

title TEXT NOT NULL,

description TEXT,

required_skill TEXT NOT NULL,

payment TEXT,

status TEXT DEFAULT 'open',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS job_hires (

id BIGSERIAL PRIMARY KEY,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

learner_id UUID NOT NULL,

status TEXT DEFAULT 'selected',

created_at TIMESTAMP DEFAULT NOW()

);



SQL



cat > services/employer-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createOpportunity(data){


const {result,error}=await db
.from("business_opportunities")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function listOpportunities(){


const {data,error}=await db
.from("business_opportunities")
.select("*")
.eq("status","open");


if(error) throw error;


return data || [];

}



async function hireLearner(opportunity_id,learner_id){


const {data,error}=await db
.from("job_hires")
.insert({

opportunity_id,

learner_id

})
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

createOpportunity,

listOpportunities,

hireLearner

};

JS



cat > api/employer.js <<'JS'
const service=require("../services/employer-service");


module.exports=async function(req,res){

try{


if(req.body.action==="post"){

return res.json(
await service.createOpportunity(
req.body.data
)
);

}



if(req.body.action==="hire"){

return res.json(
await service.hireLearner(
req.body.opportunity_id,
req.body.learner_id
)
);

}



return res.json(
await service.listOpportunities()
);



}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/employer" server.js
then

cat >> server.js <<'JS'


// Employer Marketplace API

const employer=require("./api/employer");


app.get(
"/api/employer",
employer
);


app.post(
"/api/employer",
employer
);


JS

fi



cat > public/business/post-task.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Post Business Task</title>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.box{

background:white;
padding:20px;
border-radius:12px;

}

input,textarea,button{

width:100%;
padding:10px;
margin:5px;

}

button{

background:#1565c0;
color:white;
border:0;

}

</style>

</head>


<body>


<div class="box">


<h1>🏢 Post Opportunity</h1>


<input id="title" placeholder="Task title">


<input id="skill" placeholder="Required skill">


<textarea id="description" placeholder="Description"></textarea>


<input id="payment" placeholder="Payment">


<button onclick="postTask()">

Post Task

</button>


<p id="msg"></p>


</div>



<script>


async function postTask(){


let r=await fetch(
"/api/employer",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"post",

data:{

title:title.value,

required_skill:skill.value,

description:description.value,

payment:payment.value

}

})

});


let d=await r.json();


msg.innerText=
d.error || "Task posted ✅";


}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Employer marketplace created"

echo ""
echo "Business page:"
echo "/business/post-task.html"

echo ""
echo "Flow:"
echo "Business posts task"
echo " ↓"
echo "Certified learner applies"
echo " ↓"
echo "Business hires learner"


