
async function loadPassport(){

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

const {data:profile}=await client
.from("profiles")
.select("*")
.eq("id",user.id)
.single();

const {data:certs}=await client
.from("certificates")
.select("*")
.eq("user_id",user.id);

const {data:skills}=await client
.from("learner_skills")
.select("*")
.eq("user_id",user.id);

const box=document.getElementById("passport");

box.innerHTML=`

<div class="card">

<h2>Career Passport</h2>

<p><strong>User ID:</strong> ${user.id}</p>

<p><strong>Certificates:</strong> ${certs?.length || 0}</p>

<p><strong>Skills:</strong> ${skills?.length || 0}</p>

<p><strong>XP:</strong> ${profile?.xp || 0}</p>

<p><strong>Rewards:</strong> ${profile?.reward_units || 0}</p>

</div>

`;

}

document.addEventListener(
"DOMContentLoaded",
loadPassport
);

