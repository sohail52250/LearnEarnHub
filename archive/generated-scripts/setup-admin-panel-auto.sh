#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Admin Control Panel Setup ==="

mkdir -p public/admin api services



cat > services/admin-dashboard-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function stats(){


const tables=[

"profiles",

"courses",

"certificates",

"business_opportunities",

"job_submissions",

"notifications"

];


let result={};



for(const table of tables){


const {count,error}=await db
.from(table)
.select("*",{count:"exact",head:true});


result[table]=error ? 0 : count || 0;


}



return result;


}



module.exports={
stats
};

JS



cat > api/admin-dashboard.js <<'JS'
const service=require("../services/admin-dashboard-service");


module.exports=async function(req,res){

try{

res.json(
await service.stats()
);


}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/admin-dashboard" server.js
then

cat >> server.js <<'JS'


// Admin Dashboard API

const adminDashboard=require("./api/admin-dashboard");


app.get(
"/api/admin-dashboard",
adminDashboard
);


JS

fi



cat > public/admin/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Admin Panel</title>

<style>

body{

font-family:Arial;

background:#f5f7fb;

padding:20px;

}


.card{

display:inline-block;

background:white;

padding:20px;

margin:10px;

border-radius:12px;

min-width:180px;

}


a{

display:block;

margin:10px;

}

</style>

</head>


<body>


<h1>⚙️ LearnEarnHub Admin Panel</h1>


<div id="stats">

Loading...

</div>



<h2>Management</h2>


<a href="/admin/users.html">
👥 Users
</a>


<a href="/admin/analytics.html">
📊 Analytics
</a>


<a href="/admin/course-manager.html">
📚 Courses
</a>


<a href="/admin/lesson-manager.html">
📖 Lessons
</a>


<a href="/admin/">
🏢 Business
</a>



<script>


async function load(){


let r=
await fetch(
"/api/admin-dashboard"
);


let d=
await r.json();



stats.innerHTML=

Object.entries(d)
.map(x=>`

<div class="card">

<b>${x[0]}</b>

<br>

${x[1]}

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
echo "✅ Admin control panel created"

echo ""
echo "Open:"
echo "/admin/index.html"


echo ""
echo "Dashboard includes:"
echo "Users"
echo "Courses"
echo "Certificates"
echo "Businesses"
echo "Jobs"
echo "Reports"


