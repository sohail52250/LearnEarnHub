#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Employer Candidate Search Setup ==="

mkdir -p services api/employers public/employer



cat > database/employer-search.sql <<'SQL'

CREATE TABLE IF NOT EXISTS employer_profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

company_name TEXT,

industry TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS candidate_views (

id BIGSERIAL PRIMARY KEY,

employer_id BIGINT,

learner_id UUID NOT NULL,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS candidate_skill_idx

ON learner_skills(skill_name);


SQL



cat > services/employer-search-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function searchCandidates(skill){


let query=
db
.from("learner_profiles")
.select(`
*,
learner_skills(*)
`);



if(skill){

query=query.ilike(
"learner_skills.skill_name",
"%"+skill+"%"
);

}



const {data,error}=await query;



if(error) throw error;


return data || [];

}



async function viewCandidate(data){


const {data:result,error}=await db
.from("candidate_views")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



module.exports={

searchCandidates,

viewCandidate

};

JS



cat > api/employers/candidates.js <<'JS'
const service=require("../../services/employer-search-service");


module.exports=async function(req,res){

try{


if(req.body.action==="view"){

return res.json(
await service.viewCandidate(
req.body.data
)
);

}



return res.json(
await service.searchCandidates(
req.query.skill
)
);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/employer-candidates" server.js
then

cat >> server.js <<'JS'


// Employer Candidate Search API

const employerCandidates=
require("./api/employers/candidates");


app.get(
"/api/employer-candidates",
employerCandidates
);


app.post(
"/api/employer-candidates",
employerCandidates
);


JS

fi



cat > public/employer/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Employer Dashboard</title>


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


input,button{

padding:10px;

width:90%;

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


<h1>🏢 Find Certified Learners</h1>


<input id="skill" placeholder="Search skill">


<button onclick="search()">
Search
</button>


<div id="list"></div>



<script>


async function search(){


let r=
await fetch(
"/api/employer-candidates?skill="+skill.value
);



let data=
await r.json();



list.innerHTML=
data.map(c=>`

<div class="card">

<h3>
${c.full_name || "Learner"}
</h3>

<p>
${c.bio || ""}
</p>


</div>


`).join("");

}



</script>


</body>

</html>
HTML



node -c server.js


echo ""

echo "✅ Employer Candidate Search Created"

echo ""

echo "Employers can now:"
echo "🔎 Search skills"
echo "🎓 Find certified learners"
echo "👤 View profiles"


