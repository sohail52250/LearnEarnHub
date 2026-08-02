#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Skill Unlock System Setup ==="

mkdir -p services api public



cat > database/skill-unlock.sql <<'SQL'

CREATE TABLE IF NOT EXISTS learner_skills (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,

skill_name TEXT NOT NULL,

certificate_id BIGINT REFERENCES certificates(id) ON DELETE CASCADE,

verified BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW(),


UNIQUE(user_id,course_id)

);



CREATE TABLE IF NOT EXISTS opportunity_access (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

skill_id BIGINT REFERENCES learner_skills(id) ON DELETE CASCADE,

unlocked BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS learner_skills_user_idx

ON learner_skills(user_id);


SQL



cat > services/skill-unlock-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function unlockSkill(user_id,course_id,certificate_id,skill_name){


const {data,error}=await db
.from("learner_skills")
.upsert({

user_id,

course_id,

certificate_id,

skill_name,

verified:true

})
.select()
.single();



if(error) throw error;



await db
.from("opportunity_access")
.upsert({

user_id,

skill_id:data.id,

unlocked:true

});



return data;

}



async function getSkills(user_id){


const {data,error}=await db
.from("learner_skills")
.select("*")
.eq("user_id",user_id);



if(error) throw error;


return data || [];

}



module.exports={
unlockSkill,
getSkills
};

JS



cat > api/skill-unlock.js <<'JS'
const service=require("../services/skill-unlock-service");


module.exports=async function(req,res){

try{


if(req.body.action==="unlock"){

return res.json(
await service.unlockSkill(
req.body.user_id,
req.body.course_id,
req.body.certificate_id,
req.body.skill_name
)
);

}



if(req.query.user_id){

return res.json(
await service.getSkills(
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



if ! grep -q "/api/skill-unlock" server.js
then

cat >> server.js <<'JS'


// Skill Unlock API

const skillUnlock=require("./api/skill-unlock");

app.get(
"/api/skill-unlock",
skillUnlock
);

app.post(
"/api/skill-unlock",
skillUnlock
);

JS

fi



cat > public/skills.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>My Verified Skills</title>

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
border-radius:10px;

}

</style>

</head>


<body>


<h1>🏆 My Verified Skills</h1>


<div id="skills">
Loading...
</div>



<script>


const user_id=
new URLSearchParams(location.search)
.get("user_id");



async function load(){


let r=
await fetch(
"/api/skill-unlock?user_id="+user_id
);


let data=
await r.json();



skills.innerHTML=
data.map(s=>`

<div class="card">

<h3>
${s.skill_name}
</h3>

<p>
Status: VERIFIED ✅
</p>

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
echo "✅ Skill unlock system created"

echo ""
echo "Flow:"
echo "Certificate → Verified Skill → Opportunity Access"


