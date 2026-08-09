
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

