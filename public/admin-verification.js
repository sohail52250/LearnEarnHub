async function loadVerificationRequests(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("business_profiles")
.select("*")
.eq("verified",false);



const box=document.getElementById(
"verification-list"
);



if(!data || !data.length){

box.innerHTML=
"No pending businesses";

return;

}



box.innerHTML=data.map(b=>`

<div class="card">

<h3>
${b.business_name}
</h3>


<p>
${b.industry || ""}
</p>


<button onclick="verifyBusiness('${b.id}')">

Approve

</button>


</div>

`).join("");

}



async function verifyBusiness(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("business_profiles")
.update({
verified:true
})
.eq("id",id);


location.reload();

}


document.addEventListener(
"DOMContentLoaded",
loadVerificationRequests
);


window.verifyBusiness=
verifyBusiness;
