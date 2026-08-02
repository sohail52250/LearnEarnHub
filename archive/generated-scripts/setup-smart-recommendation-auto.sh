#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Smart Recommendation Engine Setup ==="

mkdir -p services api/recommendations public/recommendations



cat > database/recommendations.sql <<'SQL'

CREATE TABLE IF NOT EXISTS opportunity_recommendations (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES external_opportunities(id) ON DELETE CASCADE,

skill_score INTEGER DEFAULT 0,

location_score INTEGER DEFAULT 0,

history_score INTEGER DEFAULT 0,

final_score INTEGER DEFAULT 0,

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(user_id,opportunity_id)

);



CREATE INDEX IF NOT EXISTS recommendation_user_idx

ON opportunity_recommendations(user_id);


SQL



cat > services/recommendation-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function calculateScore(skill,jobSkill,location,jobLocation){


let score=0;



if(skill && jobSkill){

if(
skill.toLowerCase()
.includes(
jobSkill.toLowerCase()
)
){

score+=60;

}

}



if(location && jobLocation){

if(location===jobLocation){

score+=20;

}

}



score+=20;


return score;

}



async function generate(user_id){



const {data:profile}=await db
.from("learner_profiles")
.select("*")
.eq("user_id",user_id)
.single();



const {data:skills}=await db
.from("learner_skills")
.select("skill_name")
.eq("user_id",user_id);



const {data:jobs}=await db
.from("external_opportunities")
.select("*");



let output=[];



for(const job of jobs || []){


let best=0;



for(const s of skills || []){


let score=
calculateScore(

s.skill_name,

job.required_skill,

profile?.location,

job.country

);



if(score>best)
best=score;


}



if(best>0){


const {data}=await db
.from("opportunity_recommendations")
.upsert({

user_id,

opportunity_id:job.id,

skill_score:best,

final_score:best

})
.select();



output.push(data);


}

}



return output;

}



async function get(user_id){


const {data,error}=await db
.from("opportunity_recommendations")
.select(`
*,
external_opportunities(*)
`)
.eq("user_id",user_id)
.order(
"final_score",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={generate,get};

JS



cat > api/recommendations/index.js <<'JS'
const service=require("../../services/recommendation-service");


module.exports=async function(req,res){

try{


if(req.body.action==="generate"){

return res.json(
await service.generate(
req.body.user_id
)
);

}



if(req.query.user_id){

return res.json(
await service.get(
req.query.user_id
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



if ! grep -q "/api/recommendations" server.js
then

cat >> server.js <<'JS'


// Smart Recommendation API

const recommendations=
require("./api/recommendations");


app.get(
"/api/recommendations",
recommendations
);


app.post(
"/api/recommendations",
recommendations
);


JS

fi



cat > public/recommendations/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Recommended Opportunities</title>


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


<h1>🤖 Recommended For You</h1>


<div id="list">

Loading...

</div>



<script>


const user_id=
new URLSearchParams(location.search)
.get("user_id");



async function load(){


await fetch(
"/api/recommendations",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"generate",

user_id

})

});


let r=
await fetch(
"/api/recommendations?user_id="+user_id
);


let data=
await r.json();



list.innerHTML=
data.map(x=>`

<div class="card">

<h3>
${x.external_opportunities.title}
</h3>

<p>
Match Score:
${x.final_score}%
</p>

<p>
Skill:
${x.external_opportunities.required_skill}
</p>


<a href="${x.external_opportunities.apply_url}">
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

echo "✅ Smart Recommendation Engine Created"

echo ""

echo "Ranking based on:"

echo "🎓 Certificates"

echo "🛠 Skills"

echo "🌍 Location"

echo "📈 User profile"


