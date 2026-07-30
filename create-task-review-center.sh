
#!/data/data/com.termux/files/usr/bin/bash

cat > public/task-review-center.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Task Review Center - LearnEarnHub</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>


<body>

<h1>✅ Task Review Center</h1>

<nav>
<a href="/learner-dashboard.html">Learner Dashboard</a>
</nav>

<div id="submissions">
Loading submissions...
</div>


<script src="/task-review-center.js"></script>

</body>

</html>
HTML



cat > public/task-review-center.js <<'JS'

const client = supabaseClient;


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

loadSubmissions();


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

JS


echo "Task Review Center created"

