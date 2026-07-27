#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise Analytics Dashboard"
echo "======================================"


cat > api/enterprise-analytics.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const enterprise_id=req.query.enterprise_id;


const employees=await db
.from("enterprise_employees")
.select("*")
.eq("enterprise_id",enterprise_id);


const training=await db
.from("enterprise_course_assignments")
.select("*")
.eq("enterprise_id",enterprise_id);


let total=training.data?.length || 0;

let completed=(training.data||[])
.filter(x=>x.status==="completed")
.length;


let progress=0;

if(total>0){
progress=Math.round((completed/total)*100);
}


res.json({

success:true,

analytics:{

employees:employees.data?.length || 0,

assigned_courses:total,

completed_courses:completed,

completion_rate:progress

}

});


};
JS



cat > public/enterprise-analytics.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Analytics</title>

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
Enterprise Analytics Dashboard
</h1>


<div id="dashboard">

Loading...

</div>



<script>


let enterprise_id=
localStorage.getItem("enterprise_id");


fetch("/api/enterprise-analytics?enterprise_id="+enterprise_id)

.then(r=>r.json())

.then(d=>{


let a=d.analytics||{};


dashboard.innerHTML=`

<div class="card">

<h2>
Employees
</h2>

${a.employees}

</div>


<div class="card">

<h2>
Assigned Courses
</h2>

${a.assigned_courses}

</div>


<div class="card">

<h2>
Completed Courses
</h2>

${a.completed_courses}

</div>


<div class="card">

<h2>
Training Completion Rate
</h2>

${a.completion_rate}%

</div>

`;

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add enterprise analytics dashboard" || true

git push


echo "======================================"
echo " Enterprise Analytics Added"
echo "======================================"

