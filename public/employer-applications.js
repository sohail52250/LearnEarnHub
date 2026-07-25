async function loadEmployerApplications(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;


const {data}=await client
.from("applications")
.select("*")
.order("created_at",
{ascending:false});


const box=document.getElementById(
"applicant-list"
);


if(!data || !data.length){

box.innerHTML=
"No applicants.";

return;

}


box.innerHTML=data.map(a=>`

<div class="card">

<h3>
Learner Application
</h3>

<p>
Status:
${a.status}
</p>

<a href="/learner-profile-view.html?id=${a.applicant_id}">
<button>
View Skills Passport
</button>
</a>


<button onclick="updateStatus('${a.id}','accepted')">
Accept
</button>


<button onclick="updateStatus('${a.id}','rejected')">
Reject
</button>


</div>

`).join("");

}



async function updateStatus(id,status){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("applications")
.update({
status:status
})
.eq("id",id);


location.reload();

}


document.addEventListener(
"DOMContentLoaded",
loadEmployerApplications
);


window.updateStatus=updateStatus;
