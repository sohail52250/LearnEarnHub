async function loadProfile(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const user=JSON.parse(localStorage.getItem("user")||"null");

if(!user){
location.href="/login.html";
return;
}

const {data:profile}=await client
.from("profiles")
.select("*")
.eq("id",user.id)
.single();

const {data:stats}=await client
.from("learner_stats")
.select("*")
.eq("user_id",user.id)
.single();

document.getElementById("profile-box").innerHTML=`

<h2>👤 ${profile?.name || user.email}</h2>

<p>📧 ${user.email}</p>

<hr>

<h3>⭐ Learning Stats</h3>

<p>XP: ${stats?.xp || profile?.xp || 0}</p>

<p>🏆 Level: ${stats?.level || 1}</p>

<p>📚 Courses Completed:
${stats?.completed_courses || 0}</p>

<p>🎓 Certificates:
${stats?.certificates || 0}</p>

<p>🎁 Rewards:
${profile?.reward_units || 0}</p>

`;

}

document.addEventListener(
"DOMContentLoaded",
loadProfile
);
