
async function loadBusinesses(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("business_profiles")
.select("*")
.eq("verified",true);

document.getElementById("businesses").innerHTML=
(data||[]).map(b=>`

<div class="card">

<h2>${b.company_name}</h2>

<p>${b.description||""}</p>

<p>✅ Verified Business</p>

</div>

`).join("");

}

loadBusinesses();

