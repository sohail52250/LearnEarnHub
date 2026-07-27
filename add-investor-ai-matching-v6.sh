#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investor AI Matching Engine V6"
echo "======================================"

mkdir -p database


cat > database/investor-ai-matching-v6.sql <<'SQL'

CREATE TABLE IF NOT EXISTS investor_matches (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

business_id uuid,

funding_id uuid,

match_score integer DEFAULT 0,

ai_reason text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investor-ai-matching.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


const funding_id=req.query.funding_id;


const funding=await db

.from("funding_requests")

.select("*")

.eq("id",funding_id)

.single();



const investors=await db

.from("investor_profiles")

.select("*");



let results=(investors.data||[])

.map(investor=>{


let score=0;


if(
Number(investor.investment_range||0)
>=
Number(funding.data?.funding_amount||0)
){

score+=40;

}


if(
investor.industry_focus &&
funding.data?.purpose &&
investor.industry_focus
.toLowerCase()
.includes(
funding.data.purpose.toLowerCase()
)

){

score+=30;

}


score+=30;


return {

investor,

match_score:Math.min(score,100),

reason:
"Investment capacity and business requirements analyzed"

};


})

.sort((a,b)=>
b.match_score-a.match_score
);



res.json({

success:true,

matches:results

});


};
JS



cat > public/investor-ai-matching.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investor AI Matching</title>

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


<h1>
🤖 Investor AI Matching Engine
</h1>


<div id="matches">
Loading...
</div>


<script>


let funding_id=

new URLSearchParams(location.search)

.get("funding_id");



fetch(
"/api/investor-ai-matching?funding_id="+funding_id
)

.then(r=>r.json())

.then(d=>{


matches.innerHTML=

(d.matches||[])

.map(m=>`

<div class="card">

<h3>
Investor Match
</h3>

<p>
Match Score:
${m.match_score}%
</p>

<p>
${m.reason}
</p>

</div>

`)

.join("");

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investor AI Matching Engine V6" || true

git push


echo "======================================"
echo " Investor AI Matching Completed"
echo "======================================"

