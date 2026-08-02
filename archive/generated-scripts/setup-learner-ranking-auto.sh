#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Ranking & Badge System Setup ==="

mkdir -p services api public/ranking



cat > database/learner-ranking.sql <<'SQL'

CREATE TABLE IF NOT EXISTS learner_badges (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

badge_name TEXT NOT NULL,

level TEXT DEFAULT 'Bronze',

points INTEGER DEFAULT 0,

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(user_id,badge_name)

);



CREATE TABLE IF NOT EXISTS learner_scores (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

total_points INTEGER DEFAULT 0,

level TEXT DEFAULT 'Bronze',

updated_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS learner_score_idx

ON learner_scores(total_points);


SQL



cat > services/ranking-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function calculateLevel(points){

if(points>=10000)
return "Expert";

if(points>=5000)
return "Gold";

if(points>=2000)
return "Silver";

return "Bronze";

}



async function updateScore(user_id,points){


const level=
calculateLevel(points);



const {data,error}=await db
.from("learner_scores")
.upsert({

user_id,

total_points:points,

level,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return data;

}



async function getRanking(){


const {data,error}=await db
.from("learner_scores")
.select("*")
.order(
"total_points",
{
ascending:false
}
)
.limit(100);



if(error) throw error;


return data || [];

}



module.exports={

updateScore,

getRanking

};

JS



cat > api/ranking.js <<'JS'
const service=require("../services/ranking-service");


module.exports=async function(req,res){

try{


if(req.body.action==="update"){

return res.json(
await service.updateScore(
req.body.user_id,
req.body.points
)
);

}



return res.json(
await service.getRanking()
);



}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/ranking" server.js
then

cat >> server.js <<'JS'


// Learner Ranking API

const ranking=require("./api/ranking");


app.get(
"/api/ranking",
ranking
);


app.post(
"/api/ranking",
ranking
);


JS

fi



cat > public/ranking/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Learner Ranking</title>

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


<h1>🏆 Top Learners</h1>


<div id="list">
Loading...
</div>



<script>


async function load(){


let r=
await fetch("/api/ranking");


let users=
await r.json();



list.innerHTML=
users.map((u,i)=>`

<div class="card">

<h3>
#${i+1}
</h3>

Points:
${u.total_points}

<br>

Level:
🏅 ${u.level}

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
echo "✅ Ranking and badge system created"

echo ""
echo "Levels:"
echo "0 - Bronze"
echo "2000 - Silver"
echo "5000 - Gold"
echo "10000 - Expert"

echo ""
echo "Flow:"
echo "Learning"
echo " ↓"
echo "Points"
echo " ↓"
echo "Badge"
echo " ↓"
echo "Ranking"


