#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment Command Center V15"
echo "======================================"

mkdir -p database


cat > database/investment-command-center-v15.sql <<'SQL'

CREATE TABLE IF NOT EXISTS command_center_widgets (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

widget_name text,

widget_data text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS deal_pipeline (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

deal_id uuid,

stage text DEFAULT 'review',

priority text DEFAULT 'normal',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS intelligence_notifications (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

title text,

message text,

priority text DEFAULT 'normal',

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-command-center.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const investor_id=req.query.investor_id;


const investments=await db
.from("investments")
.select("*")
.eq("investor_id",investor_id);


const pipeline=await db
.from("deal_pipeline")
.select("*")
.eq("investor_id",investor_id);


const alerts=await db
.from("intelligence_notifications")
.select("*")
.eq("investor_id",investor_id);


const compliance=await db
.from("investor_verification")
.select("*")
.eq("investor_id",investor_id);



res.json({

success:true,

summary:{

investments:
(investments.data||[]).length,

active_deals:
(pipeline.data||[]).length,

compliance_status:
compliance.data||[]

},

portfolio:
investments.data||[],

pipeline:
pipeline.data||[],

alerts:
alerts.data||[]

});


};
JS



cat > public/investment-command-center.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment Command Center</title>

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


<h1>🚀 Investment Command Center</h1>


<div id="summary" class="card">
Loading...
</div>


<div id="pipeline" class="card">
</div>


<div id="alerts" class="card">
</div>



<script>

let investor_id =
localStorage.getItem("user_id");


fetch(
"/api/investment-command-center?investor_id="+investor_id
)

.then(r=>r.json())

.then(d=>{


summary.innerHTML=

`

<h2>Portfolio Summary</h2>

Investments:
${d.summary.investments}

<br>

Active Deals:
${d.summary.active_deals}

<br>

Compliance:
${JSON.stringify(d.summary.compliance_status)}

`;



pipeline.innerHTML=

`

<h2>Deal Pipeline</h2>

<pre>
${JSON.stringify(d.pipeline,null,2)}
</pre>

`;



alerts.innerHTML=

`

<h2>AI Intelligence Alerts</h2>

<pre>
${JSON.stringify(d.alerts,null,2)}
</pre>

`;

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment Command Center V15" || true

git push


echo "======================================"
echo " Investment Command Center V15 Added"
echo "======================================"

