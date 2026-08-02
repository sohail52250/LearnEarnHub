#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Real Dashboard Setup ==="

mkdir -p public/js


cat > public/dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>

<title>LearnEarnHub Dashboard</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/js/supabase-config.js"></script>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.card{
background:white;
padding:15px;
margin:12px;
border-radius:10px;
box-shadow:0 2px 8px #ddd;
}

.bar{
height:12px;
background:#2196f3;
border-radius:10px;
}

.progress{
background:#ddd;
border-radius:10px;
}

</style>

</head>

<body>

<h1>LearnEarnHub Dashboard</h1>

<div class="card">
Email:
<span id="email"></span>
</div>


<h2>My Learning Progress</h2>

<div id="courses"></div>


<script src="/js/dashboard-real.js"></script>

</body>
</html>
HTML



cat > public/js/dashboard-real.js <<'JS'

async function loadDashboard(){

const {data:userData}=await supabaseClient.auth.getUser();


if(!userData.user){

location="/login.html";
return;

}


document.getElementById("email").innerText=
userData.user.email;


const response=await fetch(
"/api/dashboard/"+userData.user.id
);


const data=await response.json();



document.getElementById("courses").innerHTML=

data.courses.map(c=>`

<div class="card">

<h3>${c.title}</h3>

<p>
${c.completed_lessons}/${c.total_lessons}
Lessons Completed
</p>


<div class="progress">

<div class="bar"
style="width:${c.percentage}%">
</div>

</div>


<p>${c.percentage}% Complete</p>


</div>

`).join("");


}


loadDashboard();

JS



echo "✅ Real dashboard created"
echo "✅ User authentication connected"
echo "✅ Progress loading enabled"

