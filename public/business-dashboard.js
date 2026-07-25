
async function loadBusinessDashboard(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){
location.href="/login.html";
return;
}



const {data:business}=await client
.from("business_profiles")
.select("*")
.eq("user_id",user.id)
.single();



let businessId=business?.id;



const {data:offers}=await client
.from("business_opportunities")
.select("*")
.eq("business_id",businessId);



const {count}=await client
.from("job_applications")
.select("*",{count:"exact",head:true});



document.getElementById("business-panel").innerHTML=`

<div class="card">

<h1>
🏢 ${business?.company_name || "New Business"}
</h1>


<p>
${business?.description || 
"Create your professional company profile"}
</p>



<p>
${business?.verified 
?"✅ Verified Business"
:"⏳ Verification Pending"}
</p>



</div>



<div class="card">

<h2>📊 Business Overview</h2>


<p>
📢 Opportunities:
${offers?.length || 0}
</p>


<p>
👥 Applications:
${count || 0}
</p>


</div>



<div class="card">

<h2>
⚡ Quick Actions
</h2>


<a href="/post-business-offer.html">
<button>
Post Opportunity
</button>
</a>


<a href="/business-profile.html">
<button>
Edit Company Profile
</button>
</a>


<a href="/business-talent-search.html">
<button>
Find Talent
</button>
</a>


</div>



<div class="card">

<h2>
📢 Active Opportunities
</h2>


${
offers?.map(
o=>`

<div>

<h3>${o.title}</h3>

<p>${o.description}</p>

<p>
Skill:
${o.skill_required || "Any"}
</p>

</div>

<hr>

`
).join("")
||
"No opportunities posted yet"
}


</div>

`;

}


document.addEventListener(
"DOMContentLoaded",
loadBusinessDashboard
);

