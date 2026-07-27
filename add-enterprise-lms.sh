#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise LMS System"
echo "======================================"


cat > database/enterprise-lms.sql <<'SQL'

CREATE TABLE IF NOT EXISTS enterprise_course_assignments(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

employee_id uuid,

course_id uuid,

status text DEFAULT 'assigned',

progress integer DEFAULT 0,

completed_at timestamp,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS enterprise_training_reports(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

employee_id uuid,

courses_completed integer DEFAULT 0,

skills text,

score integer DEFAULT 0,

created_at timestamp DEFAULT now()

);

SQL



cat > api/enterprise-training.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const assignments=await db

.from("enterprise_course_assignments")

.select("*")

.eq("enterprise_id",enterprise_id);



return res.json({

success:true,

assignments:assignments.data||[]

});


}



if(req.method==="POST"){


const {

enterprise_id,

employee_id,

course_id

}=req.body;



const {data,error}=await db

.from("enterprise_course_assignments")

.insert([{

enterprise_id,

employee_id,

course_id

}])

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



cat > public/enterprise-training.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Training LMS</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
}

</style>

</head>


<body>


<h1>
Enterprise Training Management
</h1>


<div class="card">

<h3>
Assign Course
</h3>


<form id="assign">


<input id="employee_id"
placeholder="Employee ID">


<input id="course_id"
placeholder="Course ID">


<button>
Assign Training
</button>


</form>

</div>



<div id="result"></div>



<script>


assign.onsubmit=async(e)=>{

e.preventDefault();


let r=await fetch("/api/enterprise-training",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

enterprise_id:localStorage.getItem("enterprise_id"),

employee_id:employee_id.value,

course_id:course_id.value

})

});


let d=await r.json();

result.innerHTML=JSON.stringify(d);


};


</script>


</body>

</html>
HTML



cat > public/enterprise-training-report.html <<'HTML'
<!DOCTYPE html>
<html>

<head>
<title>Training Reports</title>
</head>

<body>

<h1>
Enterprise Training Reports
</h1>

<div id="report">
Loading reports...
</div>


</body>

</html>
HTML



git add .

git commit -m "Add enterprise LMS training management system" || true

git push


echo "======================================"
echo " Enterprise LMS Added"
echo "======================================"

