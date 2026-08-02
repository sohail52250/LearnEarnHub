#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Skill Matching Engine Setup ==="

mkdir -p services api/matching



cat > database/skill-matching.sql <<'SQL'

CREATE TABLE IF NOT EXISTS skill_matches (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

opportunity_id BIGINT REFERENCES external_opportunities(id) ON DELETE CASCADE,

matched_skill TEXT,

match_score INTEGER DEFAULT 0,

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(user_id,opportunity_id)

);



CREATE INDEX IF NOT EXISTS skill_match_user_idx

ON skill_matches(user_id);


SQL



cat > services/matching-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function calculateScore(userSkills,jobSkill){


if(!jobSkill)
return 0;


let score=0;


userSkills.forEach(skill=>{


if(
skill.toLowerCase()
.includes(
jobSkill.toLowerCase()
)
||
jobSkill.toLowerCase()
.includes(
skill.toLowerCase()
)
)

{

score=100;

}


});


return score;

}



async function matchUser(user_id){


const {data:skills}=await db
.from("learner_skills")
.select("skill_name")
.eq("user_id",user_id)
.eq("verified",true);



const {data:jobs}=await db
.from("external_opportunities")
.select("*");



let results=[];



for(const job of jobs || []){


let score=
calculateScore(
skills.map(s=>s.skill_name),
job.required_skill
);



if(score>0){


const {data}=await db
.from("skill_matches")
.upsert({

user_id,

opportunity_id:job.id,

matched_skill:job.required_skill,

match_score:score

})
.select();



results.push(data);

}


}



return results;

}



async function getMatches(user_id){


const {data,error}=await db
.from("skill_matches")
.select(`
*,
external_opportunities(*)
`)
.eq("user_id",user_id)
.order(
"match_score",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={

matchUser,

getMatches

};

JS



cat > api/matching/skills.js <<'JS'
const service=require("../../services/matching-service");


module.exports=async function(req,res){

try{


if(req.body.action==="generate"){

return res.json(
await service.matchUser(
req.body.user_id
)
);

}



if(req.query.user_id){

return res.json(
await service.getMatches(
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



if ! grep -q "/api/skill-matches" server.js
then

cat >> server.js <<'JS'


// Skill Matching API

const skillMatches=require("./api/matching/skills");


app.get(
"/api/skill-matches",
skillMatches
);


app.post(
"/api/skill-matches",
skillMatches
);


JS

fi



cat > public/matches.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Matched Opportunities</title>

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


<h1>🎯 Recommended Opportunities</h1>


<div id="list">

Loading...

</div>



<script>


const user_id=
new URLSearchParams(location.search)
.get("user_id");



async function load(){


await fetch(
"/api/skill-matches",
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
"/api/skill-matches?user_id="+user_id
);


let data=
await r.json();



list.innerHTML=
data.map(m=>`

<div class="card">

<h3>
${m.external_opportunities.title}
</h3>

<p>
Skill Match:
${m.match_score}%
</p>

<a href="${m.external_opportunities.apply_url}">
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

echo "✅ Skill Matching Engine Created"

echo ""

echo "Flow:"

echo "Certificate"

echo " ↓"

echo "Verified Skill"

echo " ↓"

echo "Global Opportunities"

echo " ↓"

echo "Match Score"

echo " ↓"

echo "Recommended Jobs"


