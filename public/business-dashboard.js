
async function loadBusinessDashboard(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const user=
JSON.parse(localStorage.getItem("user")||"null");

if(!user){
location.href="/login.html";
return;
}

const {data:business}=await client
.from("business_profiles")
.select("*")
.eq("owner_id",user.id)
.single();

const {data:opportunities}=await client
.from("business_opportunities")
.select("*")
.eq("business_user_id",user.id);

const {data:needs}=await client
.from("business_needs")
.select("*")
.eq("business_id",business?.id);

document.getElementById("business-panel").innerHTML=`

<div class="card">

<h1>
🏢 ${business?.business_name || "Business"}
</h1>

<p>
${business?.description || ""}
</p>

<p>
Verification:
${business?.verification_status || "pending"}
</p>

<p>
⭐ Trust Score:
${business?.trust_score || 0}
</p>

</div>

<div class="card">

<h2>
📊 Overview
</h2>

<p>
Opportunities:
${opportunities?.length || 0}
</p>

<p>
Business Needs:
${needs?.length || 0}
</p>

</div>

<div class="card">

<a href="/business-trust-center.html">
<button>Trust Center</button>
</a>

<a href="/post-business-offer.html">
<button>Post Opportunity</button>
</a>

<a href="/business-talent-search.html">
<button>Talent Discovery</button>
</a>

</div>

`;

}

document.addEventListener(
"DOMContentLoaded",
loadBusinessDashboard
);

