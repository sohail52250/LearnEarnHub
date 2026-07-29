async function loadApplications(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;


const {data}=await client
.from("applications")
.select("*")
.eq("applicant_id",userData.user.id);



const box=document.getElementById(
"applications"
);



if(!data || !data.length){

box.innerHTML=
"No applications yet.";

return;

}


box.innerHTML=data.map(a=>`

<div class="card">

<h3>
Application
</h3>

<p>
Status:
${a.status}
</p>

<p>
Applied:
${new Date(a.created_at)
.toLocaleDateString()}
</p>


</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadApplications
);
