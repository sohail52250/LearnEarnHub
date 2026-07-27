#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment Intelligence Platform V14"
echo "======================================"

mkdir -p database


cat > database/investment-intelligence-v14.sql <<'SQL'

CREATE TABLE IF NOT EXISTS market_insights (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

industry text,

trend_score integer DEFAULT 0,

growth_rate numeric DEFAULT 0,

market_summary text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS opportunity_scores (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

score integer DEFAULT 0,

growth_potential text,

risk_level text,

ai_analysis text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investor_insights (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

insight_type text,

summary text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS business_growth_metrics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

revenue_growth numeric DEFAULT 0,

customer_growth numeric DEFAULT 0,

market_position text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-intelligence.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const insights=await db
.from("market_insights")
.select("*")
.order("created_at",{ascending:false});


const opportunities=await db
.from("opportunity_scores")
.select("*")
.order("score",{ascending:false});


return res.json({

success:true,

market_insights:insights.data||[],

top_opportunities:opportunities.data||[]

});

}


if(req.method==="POST"){


const {data,error}=await db

.from("market_insights")

.insert([req.body])

.select();


return res.json({

success:!error,

data,

error

});


}


res.status(405).json({

error:"Method not allowed"

});


};
JS



cat > public/investment-intelligence.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment Intelligence Platform</title>

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


<h1>🧠 Investment Intelligence Platform</h1>


<div class="card">

<h2>
Market Insights
</h2>

<pre id="market">
Loading...
</pre>

</div>


<div class="card">

<h2>
Top Opportunities
</h2>

<pre id="opportunities">
Loading...
</pre>

</div>



<script>

fetch("/api/investment-intelligence")

.then(r=>r.json())

.then(d=>{


market.innerHTML=
JSON.stringify(
d.market_insights,
null,
2
);


opportunities.innerHTML=
JSON.stringify(
d.top_opportunities,
null,
2
);


});

</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment Intelligence Platform V14" || true

git push


echo "======================================"
echo " Investment Intelligence V14 Completed"
echo "======================================"

