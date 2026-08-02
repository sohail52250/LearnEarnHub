#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Global Opportunity Engine Setup ==="

mkdir -p services/connectors api/opportunities database



cat > database/global-opportunities.sql <<'SQL'

CREATE TABLE IF NOT EXISTS job_sources (

id BIGSERIAL PRIMARY KEY,

name TEXT NOT NULL,

country TEXT DEFAULT 'Global',

source_type TEXT DEFAULT 'jobs',

api_url TEXT,

active BOOLEAN DEFAULT true,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS external_opportunities (

id BIGSERIAL PRIMARY KEY,

source_id BIGINT REFERENCES job_sources(id) ON DELETE CASCADE,

title TEXT NOT NULL,

company TEXT,

description TEXT,

required_skill TEXT,

country TEXT,

remote BOOLEAN DEFAULT false,

apply_url TEXT,

opportunity_type TEXT DEFAULT 'job',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS opportunity_matches (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES external_opportunities(id) ON DELETE CASCADE,

match_score INTEGER DEFAULT 0,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS external_skill_idx

ON external_opportunities(required_skill);


SQL



cat > services/connectors/base-connector.js <<'JS'

class BaseConnector {


constructor(name){

this.name=name;

}



async fetch(){

return [];

}



normalize(job){

return {

title:job.title || "",

company:job.company || "",

description:job.description || "",

required_skill:job.skill || "",

country:job.country || "Global",

remote:job.remote || false,

apply_url:job.url || ""

};

}


}



module.exports=BaseConnector;

JS



cat > services/connectors/custom-api.js <<'JS'

const BaseConnector=require("./base-connector");


class CustomAPI extends BaseConnector {


constructor(){

super("Custom API");

}


async fetch(){

// Add approved API calls here later

return [];

}


}


module.exports=CustomAPI;

JS



cat > services/opportunity-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function listOpportunities(){


const {data,error}=await db
.from("external_opportunities")
.select("*")
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



async function addOpportunity(data){


const {data:result,error}=await db
.from("external_opportunities")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



module.exports={

listOpportunities,

addOpportunity

};

JS



cat > api/opportunities/global.js <<'JS'
const service=require("../../services/opportunity-service");


module.exports=async function(req,res){

try{


if(req.body.action==="add"){

return res.json(
await service.addOpportunity(
req.body.data
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



if ! grep -q "/api/global-opportunities" server.js
then

cat >> server.js <<'JS'


// Global Opportunity Engine API

const globalOpportunities=require("./api/opportunities/global");


app.get(
"/api/global-opportunities",
globalOpportunities
);


app.post(
"/api/global-opportunities",
globalOpportunities
);


JS

fi



cat > public/opportunities.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Global Opportunities</title>

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

</style>

</head>


<body>


<h1>🌍 Global Opportunities</h1>


<div id="list">

Loading...

</div>



<script>


async function load(){


let r=
await fetch(
"/api/global-opportunities"
);


let jobs=
await r.json();



list.innerHTML=
jobs.map(j=>`

<div class="card">

<h3>${j.title}</h3>

<p>${j.company || ""}</p>

<p>
Skill:
${j.required_skill || ""}
</p>

<a href="${j.apply_url}" target="_blank">
Apply
</a>


</div>

`).join("");

}


load();


</script>


</body>

</html>
HTML



node -c server.js



echo ""

echo "✅ Global Opportunity Engine Created"

echo ""

echo "Ready for:"
echo "🌍 Global job APIs"
echo "💼 Freelance platforms"
echo "🏢 Business offers"
echo "🎓 Internships"
echo "🔗 Partner feeds"

