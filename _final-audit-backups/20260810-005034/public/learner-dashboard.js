
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

