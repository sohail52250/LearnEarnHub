#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Student Dashboard Setup ==="

mkdir -p public


cat > public/dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Dashboard</title>

<style>
body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.card{
background:white;
padding:15px;
margin:10px 0;
border-radius:10px;
box-shadow:0 2px 8px #ddd;
}

.progress{
background:#ddd;
height:12px;
border-radius:10px;
}

.bar{
background:#2196f3;
height:12px;
border-radius:10px;
}

h1{
color:#1565c0;
}
</style>

</head>

<body>

<h1>LearnEarnHub Student Dashboard</h1>

<div id="user"></div>

<h2>My Courses</h2>

<div id="courses"></div>


<h2>Certificates</h2>

<div id="certificates"></div>


<script>

const USER_ID="00000000-0000-0000-0000-000000000001";


async function loadDashboard(){

const res=await fetch(
"/api/dashboard/"+USER_ID
);

const data=await res.json();


document.getElementById("user").innerHTML=
`
<div class="card">
User Dashboard<br>
Courses: ${data.courses.length}
</div>
`;


document.getElementById("courses").innerHTML=
data.courses.map(c=>`

<div class="card">

<h3>${c.title}</h3>

<p>${c.category}</p>

<p>
${c.completed_lessons}/${c.total_lessons}
lessons completed
</p>

<div class="progress">
<div class="bar" style="width:${c.percentage}%"></div>
</div>

<p>${c.percentage}% Complete</p>

</div>

`).join("");



document.getElementById("certificates").innerHTML=
data.certificates.length ?

data.certificates.map(c=>`
<div class="card">
Certificate Course ID: ${c.course_id}
<br>
Completed: ${c.completed_at}
</div>
`).join("")

:

"<div class='card'>No certificates yet</div>";

}


loadDashboard();

</script>


</body>
</html>
HTML


echo "✅ dashboard.html created"

echo ""
echo "Open:"
echo "/dashboard.html"

