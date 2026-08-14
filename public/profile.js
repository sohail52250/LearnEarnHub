async function loadProfile(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const user=JSON.parse(localStorage.getItem("user")||"null");

if(!user){
location.href="/auth/sign-in.html";
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


const {data:skills}=await client
.from("learner_skills")
.select("*")
.eq("user_id",user.id);


const {data:badges}=await client
.from("learner_badges")
.select("*")
.eq("user_id",user.id);


document.getElementById("profile-box").innerHTML=`

<div class="card">

<h1>🎓 ${profile?.name || "Learner"}</h1>

<p>📧 ${user.email}</p>

<hr>

<h2>⭐ Learning Level</h2>

<h3>Level ${stats?.level || 1}</h3>

<div>
XP: ${stats?.xp || 0}
</div>


<h2>📚 Progress</h2>

<p>
Completed Courses:
${stats?.completed_courses || 0}
</p>

<p>
Certificates:
${stats?.certificates || 0}
</p>


<h2>🛠 Skills</h2>

${skills?.map(
s=>`<span>${s.skill} (${s.level})</span>`
).join("<br>") || "No skills added"}


<h2>🏆 Badges</h2>

${badges?.map(
b=>`<p>🏅 ${b.badge_name}</p>`
).join("") || "No badges yet"}


<button onclick="location.href='/profile-onboarding.html'">
Edit Profile
</button>


</div>

`;

}

document.addEventListener(
"DOMContentLoaded",
loadProfile
);
