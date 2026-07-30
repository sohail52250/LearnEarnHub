
#!/data/data/termux/files/usr/bin/bash

cat > public/business-task-create.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Create Task - LearnEarnHub Business</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>


<body>

<h1>🏢 Create Earning Task</h1>


<label>Task Title</label>
<input id="title">


<br>


<label>Description</label>
<textarea id="description"></textarea>


<br>


<label>Required Skill</label>
<input id="skill">


<br>


<label>Reward Amount</label>
<input id="reward" type="number">


<br>


<label>Currency</label>
<input id="currency" value="PKR">


<br>


<button onclick="createTask()">
Create Task
</button>


<script src="/business-task-create.js"></script>


</body>

</html>
HTML



cat > public/business-task-create.js <<'JS'

const client=supabaseClient;



async function createTask(){


const user=JSON.parse(
localStorage.getItem("user") || "null"
);



if(!user){

alert("Please login");

return;

}



const task={

creator_id:user.id,

title:
document.getElementById("title").value,

description:
document.getElementById("description").value,


required_skill:
document.getElementById("skill").value,


reward_amount:
Number(
document.getElementById("reward").value
),


currency:
document.getElementById("currency").value,


status:"active"

};



const {error}=await client

.from("earning_tasks")

.insert(task);



if(error){

alert(error.message);

return;

}



alert(
"✅ Task created successfully"
);


}



JS


echo "Business Task Creator created"

