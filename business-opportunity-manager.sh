#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating Business Opportunity Manager ==="


cat > public/business-opportunity-manager.html <<'HTML'
<!DOCTYPE html>
<html>
<head>

<title>Manage Opportunities - LearnEarnHub</title>

<meta name="viewport" content="width=device-width,initial-scale=1">

<link rel="stylesheet" href="/style.css">

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>


<body>

<div id="global-header"></div>


<section class="card">

<h1>💼 Manage Opportunities</h1>


<h2>Create Opportunity</h2>


<input id="title" placeholder="Opportunity title">

<textarea id="description" placeholder="Description"></textarea>

<input id="category" placeholder="Category">

<input id="skill_required" placeholder="Required Skill">


<button onclick="createOpportunity()">
Create
</button>



<h2>Your Opportunities</h2>


<div id="list">
Loading...
</div>


</section>



<script src="/business-opportunity-manager.js"></script>


</body>
</html>
HTML



cat > public/business-opportunity-manager.js <<'JS'

const client = supabaseClient;


const user =
JSON.parse(localStorage.getItem("user") || "null");


if(!user){

location.href="/login.html";

}



async function createOpportunity(){


const payload={

business_id:user.id,

title:title.value,

description:description.value,

category:category.value,

skill_required:skill_required.value,

status:"open"

};



const {error}=await client

.from("job_opportunities")

.insert(payload);



if(error){

alert(error.message);

return;

}


alert("Opportunity created");

loadOpportunities();

}




async function loadOpportunities(){


const {data,error}=await client

.from("job_opportunities")

.select("*")

.eq("business_id",user.id)

.order("created_at",{ascending:false});



if(error){

list.innerHTML=error.message;

return;

}



list.innerHTML=(data||[]).map(item=>`


<div class="card">

<h3>
${item.title}
</h3>


<p>
${item.description || ""}
</p>


<p>
Status: ${item.status}
</p>


<button onclick="deleteOpportunity('${item.id}')">
Delete
</button>


</div>


`).join("");

}





async function deleteOpportunity(id){


if(!confirm("Delete this opportunity?"))
return;


const {error}=await client

.from("job_opportunities")

.delete()

.eq("id",id)

.eq("business_id",user.id);



if(error){

alert(error.message);

return;

}


loadOpportunities();


}



loadOpportunities();

JS



echo "=== Done ==="

