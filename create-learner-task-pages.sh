
#!/data/data/com.termux/files/usr/bin/bash

echo "Creating learner task marketplace..."

cat > public/task-marketplace.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Task Marketplace - LearnEarnHub</title>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>
</head>

<body>

<h1>🎯 Task Marketplace</h1>

<p>Complete skills-based tasks and earn rewards.</p>

<input id="search"
placeholder="Search tasks..."
onkeyup="searchTasks()">

<div id="tasks">
Loading tasks...
</div>

<script src="/task-marketplace.js"></script>

</body>
</html>
HTML


cat > public/task-marketplace.js <<'JS'

let tasks=[];

const client=supabaseClient;


async function loadTasks(){

const {data,error}=await client
.from("earning_tasks")
.select("*")
.eq("status","active")
.order("created_at",
{ascending:false});


if(error){

document.getElementById("tasks").innerHTML=
"Unable to load tasks";

console.log(error);

return;

}


tasks=data || [];

displayTasks(tasks);

}



function displayTasks(list){

document.getElementById("tasks").innerHTML=

list.map(task=>`

<div class="card">

<h2>
${task.title}
</h2>


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
${task.currency || ""}
</p>


<button onclick="submitTask('${task.id}')">
Submit Task
</button>


</div>

`).join("");

}



function searchTasks(){

let text=document
.getElementById("search")
.value
.toLowerCase();


displayTasks(

tasks.filter(t=>

t.title
.toLowerCase()
.includes(text)

)

);


}



async function submitTask(taskId){


let user=JSON.parse(

localStorage.getItem("user")
||
"null"

);


if(!user){

alert("Please login first");

return;

}



let submission=

prompt(
"Describe your submission:"
);


if(!submission)
return;



const {error}=await client

.from("task_submissions")

.insert({

task_id:taskId,

learner_id:user.id,

submission_text:submission

});



if(error){

alert(error.message);

return;

}



alert(
"✅ Task submitted successfully"
);



}



document.addEventListener(

"DOMContentLoaded",

loadTasks

);

JS


echo "Task marketplace created successfully"

