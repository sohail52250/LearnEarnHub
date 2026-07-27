#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise Hiring Portal"
echo "======================================"


cat > database/enterprise-hiring.sql <<'SQL'

CREATE TABLE IF NOT EXISTS enterprise_jobs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

title text,

description text,

skills text,

location text,

employment_type text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);



CREATE TABLE IF NOT EXISTS enterprise_job_applications(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

job_id uuid,

learner_id uuid,

status text DEFAULT 'applied',

notes text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/enterprise-jobs.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const {data,error}=await db

.from("enterprise_jobs")

.select("*")

.eq("enterprise_id",enterprise_id);



return res.json({

success:true,

jobs:data||[],

error

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("enterprise_jobs")

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



cat > api/enterprise-job-applications.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const job_id=req.query.job_id;


const {data,error}=await db

.from("enterprise_job_applications")

.select("*")

.eq("job_id",job_id);


return res.json({

success:true,

applications:data||[],

error

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("enterprise_job_applications")

.insert([req.body])

.select();



return res.json({

success:!error,

data,

error

});


}


};
JS



cat > public/enterprise-hiring.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Enterprise Hiring Portal</title>

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
Enterprise Hiring Portal
</h1>


<div class="card">


<h2>
Post New Job
</h2>


<form id="jobForm">


<input id="title"
placeholder="Job Title">


<textarea id="description"
placeholder="Job Description"></textarea>


<input id="skills"
placeholder="Required Skills">


<input id="location"
placeholder="Location">


<input id="employment_type"
placeholder="Full Time / Remote">


<button>
Post Job
</button>


</form>


</div>


<div id="jobs">
Loading...
</div>



<script>


jobForm.onsubmit=async(e)=>{

e.preventDefault();


await fetch("/api/enterprise-jobs",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

enterprise_id:
localStorage.getItem("enterprise_id"),

title:title.value,

description:description.value,

skills:skills.value,

location:location.value,

employment_type:employment_type.value

})

});


alert("Job Posted");


};



</script>


</body>

</html>
HTML



git add .

git commit -m "Add enterprise hiring portal system" || true

git push


echo "======================================"
echo " Enterprise Hiring Portal Added"
echo "======================================"

