
const client = supabaseClient;


async function loadRecommendedTasks(){


const user = JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.getElementById("recommendations").innerHTML =
"Please login first";

return;

}


// Get learner skills

const {data:skills,error:skillError}=await client

.from("learner_skills")

.select("skill")

.eq("user_id",user.id);



if(skillError){

console.log(skillError);

return;

}



const skillNames =
(skills || []).map(
s => s.skill
);



if(skillNames.length===0){

document.getElementById("recommendations").innerHTML =
"No skills added yet";

return;

}



// Find matching tasks

const {data:tasks,error}=await client

.from("earning_tasks")

.select("*")

.in("required_skill",skillNames)

.eq("status","active");



if(error){

console.log(error);

return;

}



document.getElementById("recommendations").innerHTML =

(tasks || [])
.map(task=>`

<div class="card">

<h3>
${task.title}
</h3>

<p>
${task.description || ""}
</p>

<p>
Skill:
${task.required_skill}
</p>

<p>
Reward:
${task.reward_amount}
${task.currency}
</p>

<a href="/task-marketplace.html">
View Task
</a>

</div>

`)
.join("")
||
"No matching tasks found";


}



document.addEventListener(
"DOMContentLoaded",
loadRecommendedTasks
);

