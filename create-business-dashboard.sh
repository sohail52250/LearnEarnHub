#!/data/data/com.termux/files/usr/bin/bash

echo "Creating Business Dashboard..."

cat > public/business-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Business Dashboard - LearnEarnHub</title>

<link rel="stylesheet" href="/style.css">

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>

<body>

<div id="global-header"></div>

<div class="card">

<h1>🏢 Business Dashboard</h1>

<div id="company"></div>

<h2>Add Opportunity</h2>

<input id="title" placeholder="Opportunity title">

<textarea id="description" placeholder="Description"></textarea>

<input id="contact" placeholder="Contact">

<button onclick="addOpportunity()">
Post Opportunity
</button>

<h2>Your Opportunities</h2>

<div id="jobs"></div>

</div>


<script src="/business-dashboard.js"></script>

<script src="/global-layout.js"></script>

</body>
</html>
HTML



cat > public/business-dashboard.js <<'JS'

const client = supabaseClient;


async function loadBusiness(){

let user = JSON.parse(localStorage.getItem("user"));

if(!user){

location.href="/login.html";

return;

}


let {data,error}=await client

.from("business_profiles")

.select("*")

.eq("owner_id",user.id)
.single();



if(data){

document.getElementById("company").innerHTML=`

<h3>${data.company_name}</h3>

<p>${data.description || ""}</p>

`;

}


loadJobs(user.id);


}



async function addOpportunity(){

let user = JSON.parse(localStorage.getItem("user"));


let payload={

business_id:user.id,

title:
document.getElementById("title").value,

description:
document.getElementById("description").value,

contact:
document.getElementById("contact").value

};


let {error}=await client

.from("business_opportunities")

.insert(payload);



if(error){

alert(error.message);

return;

}


alert("Opportunity Posted");

loadBusiness();


}



async function loadJobs(id){


let {data}=await client

.from("business_opportunities")

.select("*")

.eq("business_id",id);



document.getElementById("jobs").innerHTML=

(data||[]).map(j=>`

<div class="card">

<h3>${j.title}</h3>

<p>${j.description||""}</p>

</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadBusiness
);

JS



echo "Business Dashboard created"

