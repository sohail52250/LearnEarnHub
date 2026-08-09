
async function loadBusinesses(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("business_profiles")
.select("*");

const box=document.getElementById("businesses");

if(!data || !data.length){

box.innerHTML="No businesses available.";
return;

}

box.innerHTML=data.map(b=>`

<div class="card">

<h2>
🏢 ${b.business_name || "Business"}
</h2>

<p>
${b.description || ""}
</p>

<p>
⭐ Trust Score:
${b.trust_score || 0}
</p>

<p>
${b.verified ? "✅ Verified" : "⏳ Pending Verification"}
</p>

</div>

`).join("");

}

document.addEventListener(
"DOMContentLoaded",
loadBusinesses
);

