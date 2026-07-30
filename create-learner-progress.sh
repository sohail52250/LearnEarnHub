
#!/data/data/com.termux/files/usr/bin/bash

cat > public/learner-progress.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Learner Progress - LearnEarnHub</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>

<body>

<h1>📈 Learner Progress Center</h1>


<h2>🛠 Skills</h2>
<div id="skills">Loading...</div>


<h2>📋 Task Progress</h2>
<div id="tasks">Loading...</div>


<h2>💰 Earnings</h2>
<div id="earnings">Loading...</div>


<h2>🏅 Badges</h2>
<div id="badges">Loading...</div>


<script src="/learner-progress.js"></script>

</body>

</html>
HTML



cat > public/learner-progress.js <<'JS'

const client = supabaseClient;


async function loadProgress(){


const user = JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.body.innerHTML =
"Please login first";

return;

}



loadSkills(user.id);

loadTasks(user.id);

loadEarnings(user.id);

loadBadges(user.id);


}



async function loadSkills(uid){

const {data}=await client

.from("learner_skills")

.select("*")

.eq("user_id",uid);



document.getElementById("skills").innerHTML=

(data||[])
.map(s=>`

<p>
${s.skill}
-
${s.level}
</p>

`)
.join("")
||
"No skills added";


}



async function loadTasks(uid){


const {data}=await client

.from("task_submissions")

.select("*")

.eq("learner_id",uid);



document.getElementById("tasks").innerHTML=

`

<p>
Completed/Submissions:
${(data||[]).length}
</p>

`;

}





async function loadEarnings(uid){


const {data}=await client

.from("learner_earnings")

.select("*")

.eq("learner_id",uid);



let total=0;


(data||[]).forEach(e=>{

total += Number(e.amount || 0);

});



document.getElementById("earnings").innerHTML=

`

<p>
Total Earned:
${total}
</p>

`;

}





async function loadBadges(uid){


const {data}=await client

.from("learner_badges")

.select("*")

.eq("user_id",uid);



document.getElementById("badges").innerHTML=

(data||[])
.map(b=>`

<p>
🏅 ${b.badge_name || "Achievement"}
</p>

`)
.join("")
||
"No badges yet";


}



document.addEventListener(
"DOMContentLoaded",
loadProgress
);

JS


echo "Learner Progress Center created"

