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
<h2>No opportunities yet</h2>
<p>New opportunities will appear here.</p>
</div>
`;

return;

}


box.innerHTML=jobs.map(job=>`

<div class="card">

<h2>💼 ${job.title}</h2>

<p>${job.description}</p>

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


const {data:user}=await client.auth.getUser();


if(!user.user){

alert("Please login first");

return;

}


await client
.from("applications")
.insert({

job_id:jobId,

student_id:user.user.id,

status:"pending"

});


alert("Application submitted");

}


document.addEventListener(
"DOMContentLoaded",
loadJobs
);
