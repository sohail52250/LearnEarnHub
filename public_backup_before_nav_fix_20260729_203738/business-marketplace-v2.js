
let jobs=[];


async function loadJobs(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data,error}=await client

.from("job_opportunities")

.select("*")

.eq("status","open")

.order("created_at",{ascending:false});



if(error){

document.getElementById("jobs").innerHTML=
"Unable to load opportunities";

return;

}



jobs=data || [];

displayJobs(jobs);


}



function displayJobs(list){


document.getElementById("jobs").innerHTML=


list.map(job=>`

<div class="card">


<h2>
💼 ${job.title}
</h2>


<p>
${job.description || ""}
</p>


<p>
🛠 Skill:
${job.skill_required || "Not specified"}
</p>


<p>
Status:
${job.status}
</p>



<button onclick="applyJob(${job.id})">

Apply Now

</button>



</div>


`).join("");

}




function searchJobs(){


const text=document
.getElementById("jobSearch")
.value
.toLowerCase();



displayJobs(

jobs.filter(j=>

j.title.toLowerCase()
.includes(text)

)

);


}





async function applyJob(id){


const user=JSON.parse(
localStorage.getItem("user") || "null"
);



if(!user){

alert("Please login first");

return;

}



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client

.from("job_applications")

.insert({

job_id:id,

learner_id:user.id

});



if(error){

alert(error.message);

return;

}



alert(
"Application submitted successfully"
);


}



document.addEventListener(
"DOMContentLoaded",
loadJobs
);


