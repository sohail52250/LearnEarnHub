async function loadApplicationsCenter(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:userData}=await client.auth.getUser();

if(!userData.user){
location.href="/login.html";
return;
}

const businessUserId=userData.user.id;

const {data:opportunities}=await client
.from("business_opportunities")
.select("*")
.eq("business_user_id",businessUserId);

const ids=(opportunities||[])
.map(o=>o.id);

if(ids.length===0){

document.getElementById("stats").innerHTML=
"<div class='card'>No opportunities yet</div>";

document.getElementById("applications").innerHTML="";
return;
}

const {data:applications}=await client
.from("applications")
.select("*")
.in("opportunity_id",ids);

document.getElementById("stats").innerHTML=`
<div class="card">
<h2>📊 Business Analytics</h2>

<p>
Opportunities:
${opportunities.length}
</p>

<p>
Applications:
${applications?.length || 0}
</p>

</div>
`;

let html="";

for(const app of (applications||[])){

const {data:profile}=await client
.from("profiles")
.select("*")
.eq("id",app.learner_id)
.single();

const {data:skills}=await client
.from("learner_skills")
.select("*")
.eq("user_id",app.learner_id);

const {data:certs}=await client
.from("certificates")
.select("*")
.eq("user_id",app.learner_id);

html+=`
<div class="card">

<h3>
👤 ${profile?.full_name || "Learner"}
</h3>

<p>
Status:
${app.status || "pending"}
</p>

<p>
Skills:
${(skills||[])
.map(s=>s.skill_name || s.skill)
.join(", ") || "None"}
</p>

<p>
Certificates:
${certs?.length || 0}
</p>

<button onclick="updateStatus(${app.id},'shortlisted')">
⭐ Shortlist
</button>

<button onclick="updateStatus(${app.id},'accepted')">
✅ Accept
</button>

<button onclick="updateStatus(${app.id},'rejected')">
❌ Reject
</button>

</div>
`;
}

document.getElementById("applications").innerHTML=
html || "No applications found";
}

async function updateStatus(id,status){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

await client
.from("applications")
.update({status})
.eq("id",id);

loadApplicationsCenter();
}

document.addEventListener(
"DOMContentLoaded",
loadApplicationsCenter
);
