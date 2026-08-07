
const client=supabaseClient;



async function loadBusinessTasks(){


const user=JSON.parse(

localStorage.getItem("user") || "null"

);



if(!user){

document.body.innerHTML=
"Please login";

return;

}



const {data,error}=await client

.from("earning_tasks")

.select("*")

.eq("creator_id",user.id)

.order(
"created_at",
{ascending:false}
);



if(error){

console.log(error);

return;

}



document.getElementById("tasks").innerHTML=

(data||[])
.map(t=>`

<div class="card">

<h2>
${t.title}
</h2>


<p>
${t.description || ""}
</p>


<p>
Skill:
${t.required_skill}
</p>


<p>
Reward:
${t.reward_amount}
${t.currency}
</p>


<p>
Status:
${t.status}
</p>


<button onclick="toggleTask(${t.id}, '${t.status}')">

${t.status==="active"
?"Pause"
:"Activate"}

</button>


</div>

`)
.join("")
||
"No tasks created";


}



async function toggleTask(id,status){


let newStatus =
status==="active"
?
"inactive"
:
"active";



await client

.from("earning_tasks")

.update({

status:newStatus

})

.eq("id",id);



alert(
"Task updated"
);


loadBusinessTasks();


}



document.addEventListener(

"DOMContentLoaded",

loadBusinessTasks

);

