#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment Management Dashboard V7"
echo "======================================"

mkdir -p database


cat > database/investment-management-v7.sql <<'SQL'

CREATE TABLE IF NOT EXISTS investments (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

business_id uuid,

funding_id uuid,

amount numeric DEFAULT 0,

equity text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investment_returns (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investment_id uuid,

roi_percent numeric DEFAULT 0,

return_amount numeric DEFAULT 0,

report_note text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS investor_portfolio_logs (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

action text,

details text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-dashboard.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


const investor_id=req.query.investor_id;


const investments=await db

.from("investments")

.select("*")

.eq("investor_id",investor_id);



const returns=await db

.from("investment_returns")

.select("*");



let totalInvestment=0;


(investments.data||[])

.forEach(i=>{

totalInvestment += Number(i.amount||0);

});



let totalReturn=0;


(returns.data||[])

.forEach(r=>{

totalReturn += Number(r.return_amount||0);

});



res.json({

success:true,

portfolio:{

total_investment:totalInvestment,

total_returns:totalReturn,

active_investments:
(investments.data||[]).length

},

investments:
investments.data||[]

});


};
JS



cat > public/investment-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment Dashboard</title>

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


<h1>
📈 Investor Portfolio Dashboard
</h1>


<div id="summary">
Loading...
</div>


<div id="list">
</div>



<script>


let investor_id=

localStorage.getItem("user_id");



fetch(
"/api/investment-dashboard?investor_id="+investor_id
)

.then(r=>r.json())

.then(d=>{


summary.innerHTML=`

<div class="card">

<h3>Total Investment</h3>

${d.portfolio.total_investment}

</div>


<div class="card">

<h3>Total Returns</h3>

${d.portfolio.total_returns}

</div>


<div class="card">

<h3>Active Investments</h3>

${d.portfolio.active_investments}

</div>

`;



list.innerHTML=

(d.investments||[])

.map(i=>`

<div class="card">

Business:
${i.business_id}

<br>

Amount:
${i.amount}

<br>

Status:
${i.status}

</div>

`)

.join("");

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment Management Dashboard V7" || true

git push


echo "======================================"
echo " Investment Dashboard Added"
echo "======================================"

