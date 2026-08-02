#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Employer Job Posting Setup ==="

mkdir -p api/employer-posts services public/post-job



cat > database/employer-posts.sql <<'SQL'

CREATE TABLE IF NOT EXISTS employer_jobs (

id BIGSERIAL PRIMARY KEY,

employer_id UUID NOT NULL,

title TEXT NOT NULL,

company TEXT,

description TEXT,

required_skills TEXT,

job_type TEXT DEFAULT 'job',

country TEXT DEFAULT 'Global',

remote BOOLEAN DEFAULT false,

salary TEXT,

status TEXT DEFAULT 'pending',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS employer_jobs_skill_idx

ON employer_jobs(required_skills);


SQL



cat > services/employer-post-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createJob(data){


const {data:job,error}=await db
.from("employer_jobs")
.insert({

...data,

status:"pending"

})
.select()
.single();



if(error) throw error;


return job;

}



async function listJobs(){


const {data,error}=await db
.from("employer_jobs")
.select("*")
.eq(
"status",
"approved"
)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={

createJob,

listJobs

};

JS



cat > api/employer-posts/index.js <<'JS'
const service=require("../../services/employer-post-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createJob(
req.body.data
)
);

}



return res.json(
await service.listJobs()
);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/employer-posts" server.js
then

cat >> server.js <<'JS'


// Employer Job Posting API

const employerPosts=
require("./api/employer-posts");


app.get(
"/api/employer-posts",
employerPosts
);


app.post(
"/api/employer-posts",
employerPosts
);


JS

fi



cat > public/post-job/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Post Opportunity</title>


<style>

body{

font-family:Arial;

background:#f5f7fb;

padding:20px;

}


.card{

background:white;

padding:20px;

border-radius:12px;

}


input,textarea,button,select{

width:90%;

padding:10px;

margin:6px;

}


button{

background:#1565c0;

color:white;

border:0;

}

</style>


</head>


<body>


<div class="card">


<h1>🏢 Post Job / Task</h1>


<input id="employer_id" placeholder="Employer ID">


<input id="title" placeholder="Job Title">


<input id="company" placeholder="Company">


<textarea id="description" placeholder="Description"></textarea>


<input id="skills" placeholder="Required Skills">


<select id="type">

<option>job</option>

<option>task</option>

<option>freelance</option>

<option>internship</option>

</select>


<button onclick="postJob()">

Submit

</button>


<p id="msg"></p>


</div>



<script>


async function postJob(){


let r=
await fetch(
"/api/employer-posts",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"create",

data:{

employer_id:employer_id.value,

title:title.value,

company:company.value,

description:description.value,

required_skills:skills.value,

job_type:type.value

}

})

});


let d=
await r.json();


msg.innerText=
d.error || "Submitted for approval ✅";


}


</script>


</body>

</html>
HTML



node -c server.js


echo ""

echo "✅ Employer Job Posting System Created"

echo ""

echo "Features:"

echo "🏢 Business posting"

echo "💼 Jobs"

echo "📝 Tasks"

echo "🎓 Internships"

echo "🔐 Admin approval ready"


