#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment Reports & Analytics V8"
echo "======================================"

mkdir -p database


cat > database/investment-analytics-v8.sql <<'SQL'

CREATE TABLE IF NOT EXISTS investment_reports (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

report_type text,

total_investment numeric DEFAULT 0,

total_return numeric DEFAULT 0,

roi_percent numeric DEFAULT 0,

risk_level text,

summary text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS business_performance_metrics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

business_id uuid,

revenue numeric DEFAULT 0,

growth_percent numeric DEFAULT 0,

market_score integer DEFAULT 0,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-analytics.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


const investor_id=req.query.investor_id;


const investments=await db

.from("investments")

.select("*")

.eq("investor_id",investor_id);



let totalInvestment=0;


(investments.data||[]).forEach(i=>{

totalInvestment += Number(i.amount||0);

});


const returns=await db

.from("investment_returns")

.select("*");


let totalReturn=0;


(returns.data||[]).forEach(r=>{

totalReturn += Number(r.return_amount||0);

});


let roi=0;


if(totalInvestment>0){

roi=((totalReturn-totalInvestment)/totalInvestment)*100;

}


let risk=

roi>20 ?

"Low Risk / Strong Performance":

roi>0 ?

"Moderate Risk":

"High Risk";


const report={

total_investment:totalInvestment,

total_return:totalReturn,

roi_percent:
roi.toFixed(2),

risk_level:risk,

generated:
new Date()

};



await db

.from("investment_reports")

.insert([{

investor_id,

report_type:"performance",

total_investment:totalInvestment,

total_return:totalReturn,

roi_percent:roi,

risk_level:risk,

summary:
JSON.stringify(report)

}]);



res.json({

success:true,

report

});


};
JS



cat > public/investment-analytics.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment Analytics</title>

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


<h1>📊 Investment Reports & Analytics</h1>


<div id="report">

Loading...

</div>


<script>


let investor_id=

localStorage.getItem("user_id");


fetch(
"/api/investment-analytics?investor_id="+investor_id
)

.then(r=>r.json())

.then(d=>{


report.innerHTML=`

<div class="card">

<h3>Total Investment</h3>

${d.report.total_investment}

</div>


<div class="card">

<h3>Total Return</h3>

${d.report.total_return}

</div>


<div class="card">

<h3>ROI</h3>

${d.report.roi_percent}%

</div>


<div class="card">

<h3>Risk Level</h3>

${d.report.risk_level}

</div>

`;

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment Reports and Analytics V8" || true

git push


echo "======================================"
echo " Investment Analytics V8 Completed"
echo "======================================"

