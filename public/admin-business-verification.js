
async function loadVerification(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data}=await client
.from("business_verification_requests")
.select("*")
.order("created_at",{ascending:false});



document.getElementById("list").innerHTML=

(data||[]).map(x=>`

<div class="card">

<h3>${x.business_name}</h3>

<p>Status: ${x.verification_status}</p>


<button onclick="approve(${x.id})">
Approve
</button>


<button onclick="reject(${x.id})">
Reject
</button>

</div>

`).join("");

}



async function update(id,status){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("business_verification_requests")
.update({
verification_status:status
})
.eq("id",id);


loadVerification();

}



function approve(id){

update(id,"approved");

}


function reject(id){

update(id,"rejected");

}



document.addEventListener(
"DOMContentLoaded",
loadVerification
);

