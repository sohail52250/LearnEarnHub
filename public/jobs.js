async function loadJobs(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:jobs,error}=await client
.from("jobs")
.select("*")
.eq("status","active")
.order("created_at",{ascending:false});


const box=document.getElementById("jobs-list");

if(!box) return;


if(error || !jobs || jobs.length===0){

box.innerHTML=`
<div class="card">
<h2>No opportunities available yet</h2>
<p>New jobs will appear soon.</p>
</div>
`;

return;

}


box.innerHTML=jobs.map(job=>`

<div class="card">

<h2>💼 ${job.title}</h2>

<p>${job.description || ""}</p>

<p>
⭐ Skills:
${job.skills_required || "Not specified"}
</p>

<button onclick="applyJob('${job.id}')">
Apply
</button>

</div>

`).join("");

}



async function applyJob(jobId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Please login first");

return;

}


await client
.from("applications")
.insert({

job_id:jobId,

student_id:userData.user.id,

status:"pending"

});


alert("Application submitted successfully");

}


document.addEventListener(
"DOMContentLoaded",
loadJobs
);


window.applyJob=applyJob;


async function loadExternalJobs(){
 const r=await fetch('/api/external/jobs-feed');
 const data=await r.json();

 const box=document.getElementById('jobs');

 if(box && data.jobs){
 box.innerHTML=data.jobs.map(j=>`
 <div class="job-card">
 <h3>${j.title}</h3>
 <p>${j.category}</p>
 <p>${j.type}</p>
 <p>${j.reward}</p>
 </div>
 `).join('');
 }
}

loadExternalJobs();
