
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

