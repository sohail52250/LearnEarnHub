async function loadBusinessTrust(){

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


if(!business){
document.getElementById("trust-box").innerHTML=
"No business profile found";
return;
}


let score=0;

if(business.company_name) score+=20;
if(business.description) score+=20;
if(business.verified) score+=40;
score+=20;


let badge="⚪ Basic Business";

if(score>=80){
badge="⭐ Trusted Business";
}
else if(score>=50){
badge="🔵 Verified Business";
}


document.getElementById("trust-box").innerHTML=`

<div class="card">

<h2>${business.company_name}</h2>

<h3>${badge}</h3>

<p>
Trust Score: ${score}/100
</p>

<p>
Advertisement Status:
${business.ad_status || "No Active Advertisement"}
</p>


<p>
Verification:
${business.verified 
?"✅ Verified"
:"⏳ Pending Verification"}
</p>

</div>

`;

}


document.addEventListener(
"DOMContentLoaded",
loadBusinessTrust
);
