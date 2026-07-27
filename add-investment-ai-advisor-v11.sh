#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment AI Advisor V11"
echo "======================================"

mkdir -p database


cat > database/investment-ai-advisor-v11.sql <<'SQL'

CREATE TABLE IF NOT EXISTS investor_preferences (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

preferred_industry text,

risk_level text,

investment_capacity numeric DEFAULT 0,

preferred_location text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS ai_investment_recommendations (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

business_id uuid,

score integer DEFAULT 0,

risk_rating text,

ai_reason text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS ai_advisor_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

report text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-ai-advisor.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


const investor_id=req.query.investor_id;


const preferences=await db

.from("investor_preferences")

.select("*")

.eq("investor_id",investor_id)

.single();



const opportunities=await db

.from("funding_requests")

.select("*");



let recommendations=(opportunities.data||[])

.map(item=>{


let score=50;


if(preferences.data){

if(
Number(preferences.data.investment_capacity||0)
>=
Number(item.funding_amount||0)
){

score+=30;

}

}


return {

business_id:item.business_id,

funding_id:item.id,

score:Math.min(score,100),

risk_rating:
score>70?"Medium":"High",

reason:
"Matched using investment capacity and opportunity data"

};


})

.sort((a,b)=>b.score-a.score);



let report=

"AI Investment Advisor Report\n\n"+

"Recommended Opportunities: "

+recommendations.length;



await db

.from("ai_advisor_reports")

.insert([{

investor_id,

report

}]);



res.json({

success:true,

report,

recommendations

});


};
JS



cat > public/investment-ai-advisor.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment AI Advisor</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:20px;
margin:10px;
border-radius:12px;
}

</style>

</head>


<body>


<h1>🤖 Investment AI Advisor</h1>


<div id="result">
Loading...
</div>


<script>

let investor_id=

localStorage.getItem("user_id");


fetch(
"/api/investment-ai-advisor?investor_id="+investor_id
)

.then(r=>r.json())

.then(d=>{


result.innerHTML=

`

<div class="card">

<h3>AI Report</h3>

<pre>${d.report}</pre>

</div>


${(d.recommendations||[])

.map(x=>`

<div class="card">

<h3>
Opportunity Match
</h3>

<p>
Score: ${x.score}%
</p>

<p>
Risk: ${x.risk_rating}
</p>

<p>
${x.reason}
</p>

</div>

`).join("")}

`;

});

</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment AI Advisor V11" || true

git push


echo "======================================"
echo " Investment AI Advisor V11 Completed"
echo "======================================"

