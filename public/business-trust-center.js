
async function loadTrust(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:{user}}=
await client.auth.getUser();


if(!user){

location.href="/auth/sign-in.html";

return;

}


const {data}=await client

.from("business_profiles")

.select("*")

.eq("owner_id",user.id)

.single();



document.getElementById("trust").innerHTML=`

<div class="card">

<h2>
${data?.business_name || "Business"}
</h2>


<p>
Verification:
${data?.verification_status || "pending"}
</p>


<p>
⭐ Trust Score:
${data?.trust_score || 0}
</p>


<p>
Badge:
${data?.verified ? "✅ Verified" : "⏳ Pending"}
</p>


</div>

`;

}


document.addEventListener(
"DOMContentLoaded",
loadTrust
);

