
async function checkAdmin(){

let {data}=await supabaseClient.auth.getSession();

if(!data.session){

location.href="/admin-login.html";
return;

}

loadRequests();

}


async function loadRequests(){

let box=document.getElementById("requests");

let {data,error}=await supabaseClient
.from("partnership_requests")
.select("*")
.order("created_at",{ascending:false});


if(error){

box.innerHTML=error.message;
return;

}


box.innerHTML=data.map(r=>`

<div class="card">

<h3>${r.name}</h3>

<p>Email: ${r.email}</p>

<p>${r.details}</p>

<p>Status: ${r.status || "pending"}</p>

<button onclick="updateStatus('${r.id}','approved')">
Approve
</button>

<button onclick="updateStatus('${r.id}','rejected')">
Reject
</button>


</div>

`).join("");

}



async function updateStatus(id,status){

await supabaseClient
.from("partnership_requests")
.update({
status:status,
reviewed_at:new Date()
})
.eq("id",id);


loadRequests();

}



async function logout(){

await supabaseClient.auth.signOut();

location.href="/admin-login.html";

}


checkAdmin();

