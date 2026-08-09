
async function loadBusinesses(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client

.from("business_profiles")

.select("*")

.order("created_at",{ascending:false});


const box=document.getElementById(
"businessQueue"
);


if(error){

box.innerHTML="Unable to load businesses";

return;

}


box.innerHTML=(data||[]).map(b=>`

<div class="card">

<h2>
🏢 ${b.business_name || "Business"}
</h2>


<p>
Category:
${b.category || "Not added"}
</p>


<p>
Location:
${b.location || "Not added"}
</p>


<p>
Verification:
${b.verification_status || "pending"}
</p>


<p>
Trust Score:
${b.trust_score || 0}
</p>


<button onclick="verifyBusiness('${b.id}')">

✅ Verify

</button>


<button onclick="rejectBusiness('${b.id}')">

❌ Reject

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

verified:true,

verification_status:"approved",

verified_at:new Date()

})

.eq("id",id);


alert(
"Business verified"
);


location.reload();

}



async function rejectBusiness(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client

.from("business_profiles")

.update({

verified:false,

verification_status:"rejected"

})

.eq("id",id);


alert(
"Business rejected"
);


location.reload();

}



document.addEventListener(
"DOMContentLoaded",
loadBusinesses
);


