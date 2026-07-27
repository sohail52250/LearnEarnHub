#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Enterprise Section"
echo "======================================"


mkdir -p public


cat > database/enterprise.sql <<'SQL'

CREATE TABLE IF NOT EXISTS enterprises(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid UNIQUE,

company_name text,

industry text,

description text,

website text,

email text,

phone text,

city text,

country text,

employees text,

verification_status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_training(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

course_id uuid,

assigned_to uuid,

status text DEFAULT 'assigned',

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_employees(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

employee_id uuid,

role text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/enterprise-dashboard.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const enterprise=await db
.from("enterprises")
.select("*")
.eq("user_id",user_id)
.single();


const employees=await db
.from("enterprise_employees")
.select("*")
.eq("enterprise_id",enterprise.data?.id);


const training=await db
.from("enterprise_training")
.select("*")
.eq("enterprise_id",enterprise.data?.id);


res.json({

success:true,

enterprise:enterprise.data,

employees:employees.data||[],

training:training.data||[]

});


};
JS



cat > public/enterprise-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Dashboard</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:10px;
}

</style>

</head>


<body>


<h1>
Enterprise Dashboard
</h1>


<div id="app">
Loading...
</div>


<script>

let user_id=localStorage.getItem("user_id");


fetch("/api/enterprise-dashboard?user_id="+user_id)

.then(r=>r.json())

.then(d=>{


let e=d.enterprise||{};


app.innerHTML=`

<div class="card">

<h2>
${e.company_name||"Enterprise"}
</h2>

<p>
Industry:
${e.industry||""}
</p>

<p>
Verification:
${e.verification_status||"pending"}
</p>

</div>


<div class="card">

<h3>
Employees
</h3>

${d.employees.length}

</div>


<div class="card">

<h3>
Assigned Training
</h3>

${d.training.length}

</div>

`;

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add enterprise section foundation" || true

git push


echo "======================================"
echo " Enterprise Section Added"
echo "======================================"

