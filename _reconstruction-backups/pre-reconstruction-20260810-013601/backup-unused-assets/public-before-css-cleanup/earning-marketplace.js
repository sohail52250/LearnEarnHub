
async function loadTasks(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("earning_tasks")
.select("*")
.eq("status","open");


document.getElementById("tasks").innerHTML=

(data||[]).map(t=>`

<div class="card">

<h3>${t.title}</h3>

<p>${t.description}</p>

<p>
Skill: ${t.required_skill}
</p>

<p>
Reward: PKR ${t.reward_amount}
</p>


<button onclick="applyTask(${t.id})">
Apply
</button>


</div>

`).join("");

}



async function applyTask(id){

const user=
JSON.parse(localStorage.getItem("user")||"null");


if(!user){

alert("Login required");

return;

}


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("task_applications")
.insert({

task_id:id,

learner_id:user.id,

application_message:
"Interested in this task"

});


alert("Application sent");

}


document.addEventListener(
"DOMContentLoaded",
loadTasks
);

