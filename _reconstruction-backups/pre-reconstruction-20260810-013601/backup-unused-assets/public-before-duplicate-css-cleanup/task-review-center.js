
const client = supabaseClient;


// Access protection

async function checkReviewerAccess(){

const user = JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.body.innerHTML =
"Please login first";

throw new Error("No user");

}


// Check admin table

const {data:admin}=await client

.from("admin_users")

.select("*")

.eq("user_id",user.id)

.single();



if(!admin){

document.body.innerHTML =
"Access denied. Reviewer only.";

throw new Error("No permission");

}


}





async function loadSubmissions(){


const {data,error}=await client

.from("task_submissions")

.select("*")

.eq("status","pending");



if(error){

console.log(error);

return;

}



document.getElementById("submissions").innerHTML =

(data||[])
.map(s=>`

<div class="card">

<h3>
Submission
${s.id}
</h3>


<p>
Task ID:
${s.task_id}
</p>


<p>
Learner:
${s.learner_id}
</p>


<p>
${s.submission_text || ""}
</p>


<button onclick="approveTask(${s.id}, '${s.learner_id}', ${s.task_id})">

Approve

</button>


<button onclick="rejectTask(${s.id})">

Reject

</button>


</div>

`)
.join("")
||
"No pending submissions";


}





async function approveTask(id,learnerId,taskId){


const {error}=await client

.from("task_submissions")

.update({

status:"approved"

})

.eq("id",id);



if(error){

alert(error.message);

return;

}



// Get task reward

const {data:task}=await client

.from("earning_tasks")

.select("*")

.eq("id",taskId)

.single();



if(task){


await client

.from("learner_earnings")

.insert({

learner_id:learnerId,

task_id:taskId,

amount:task.reward_amount,

currency:task.currency,

payment_status:"approved"

});


}



alert("Task approved");

checkReviewerAccess().then(loadSubmissions);


}




async function rejectTask(id){


await client

.from("task_submissions")

.update({

status:"rejected"

})

.eq("id",id);


alert("Task rejected");

loadSubmissions();


}



document.addEventListener(

"DOMContentLoaded",

loadSubmissions

);

