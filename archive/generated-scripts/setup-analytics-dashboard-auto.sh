#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Analytics Dashboard Setup ==="

mkdir -p services api public/admin



cat > services/analytics-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function dashboardStats(){


const {count:users}=await db
.from("profiles")
.select("*",{count:"exact",head:true});



const {count:courses}=await db
.from("courses")
.select("*",{count:"exact",head:true});



const {count:lessons}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true});



const {count:progress}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("completed",true);



const {count:certificates}=await db
.from("certificates")
.select("*",{count:"exact",head:true});



return {

total_users:users||0,

total_courses:courses||0,

total_lessons:lessons||0,

completed_lessons:progress||0,

certificates:certificates||0

};


}



async function categoryReport(){


const {data,error}=await db
.from("courses")
.select("category");


if(error) throw error;



let result={};


data.forEach(x=>{

let c=x.category || "Other";

result[c]=(result[c]||0)+1;

});


return result;


}



module.exports={
dashboardStats,
categoryReport
};

JS



cat > api/analytics.js <<'JS'
const service=require("../services/analytics-service");


module.exports=async function(req,res){

try{


if(req.query.action==="stats"){

return res.json(
await service.dashboardStats()
);

}



if(req.query.action==="categories"){

return res.json(
await service.categoryReport()
);

}



res.status(400).json({
error:"Invalid action"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/analytics" server.js
then

cat >> server.js <<'JS'


// Analytics API

const analytics=require("./api/analytics");

app.get(
"/api/analytics",
analytics
);

JS

fi



cat > public/admin/analytics.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Analytics Dashboard</title>


<style>

body{

font-family:Arial;

background:#f5f7fb;

padding:20px;

}


.card{

background:white;

padding:20px;

margin:10px;

border-radius:12px;

display:inline-block;

min-width:180px;

box-shadow:0 2px 8px #ccc;

}


</style>


</head>


<body>


<h1>📊 LearnEarnHub Analytics</h1>



<div id="stats">

Loading...

</div>



<h2>Course Categories</h2>

<div id="categories"></div>



<script>


async function load(){


let s=
await fetch(
"/api/analytics?action=stats"
);


let stats=
await s.json();



document.getElementById("stats")
.innerHTML=`

<div class="card">
Users<br>
<b>${stats.total_users}</b>
</div>

<div class="card">
Courses<br>
<b>${stats.total_courses}</b>
</div>

<div class="card">
Lessons<br>
<b>${stats.total_lessons}</b>
</div>

<div class="card">
Completed Lessons<br>
<b>${stats.completed_lessons}</b>
</div>

<div class="card">
Certificates<br>
<b>${stats.certificates}</b>
</div>

`;



let c=
await fetch(
"/api/analytics?action=categories"
);


let categories=
await c.json();



document.getElementById("categories")
.innerHTML=
Object.entries(categories)
.map(x=>`

<div class="card">
${x[0]}<br>
<b>${x[1]}</b>
</div>

`).join("");

}


load();


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Analytics dashboard created"

echo ""
echo "Open:"
echo "/admin/analytics.html"


