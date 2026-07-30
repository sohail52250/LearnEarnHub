
#!/data/data/Termux/files/usr/bin/bash

cat > public/learner-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Learner Dashboard - LearnEarnHub</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>

<body>

<h1>🎓 Learner Dashboard</h1>

<h2>My Skills</h2>
<div id="skills">Loading...</div>


<h2>My Submitted Tasks</h2>
<div id="tasks">Loading...</div>


<h2>My Earnings</h2>
<div id="earnings">Loading...</div>


<h2>My Badges</h2>
<div id="badges">Loading...</div>


<script src="/learner-dashboard.js"></script>

</body>
</html>
HTML



cat > public/learner-dashboard.js <<'JS'

const client=supabaseClient;


async function loadDashboard(){


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.body.innerHTML=
"Please login first";

return;

}



loadSkills(user.id);

loadTasks(user.id);

loadEarnings(user.id);

loadBadges(user.id);


}



async function loadSkills(uid){

let {data}=await client

.from("learner_skills")

.select("*")

.eq("user_id",uid);


document.getElementById("skills").innerHTML=

(data||[])
.map(s=>`
<p>
${s.skill}
 - ${s.level}
</p>
`)
.join("")
||
"No skills added";


}




async function loadTasks(uid){

let {data}=await client

.from("task_submissions")

.select("*")

.eq("learner_id",uid);


document.getElementById("tasks").innerHTML=

(data||[])
.map(t=>`

<p>
Task ID: ${t.task_id}
<br>
Status: ${t.status}
</p>

`)
.join("")
||
"No submitted tasks";


}





async function loadEarnings(uid){

let {data}=await client

.from("learner_earnings")

.select("*")

.eq("learner_id",uid);



document.getElementById("earnings").innerHTML=

(data||[])
.map(e=>`

<p>
${e.amount} ${e.currency}
<br>
Status:
${e.payment_status}
</p>

`)
.join("")
||
"No earnings yet";


}





async function loadBadges(uid){

let {data}=await client

.from("learner_badges")

.select("*")

.eq("user_id",uid);



document.getElementById("badges").innerHTML=

(data||[])
.map(b=>`

<p>
🏅 ${b.badge_name || "Badge"}
</p>

`)
.join("")
||
"No badges yet";


}




document.addEventListener(
"DOMContentLoaded",
loadDashboard
);

JS


echo "Learner Dashboard created"

