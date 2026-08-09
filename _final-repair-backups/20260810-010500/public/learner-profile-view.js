async function loadLearnerProfile(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const params =
new URLSearchParams(
window.location.search
);


const userId =
params.get("id");


if(!userId)return;



const {data:career}=await client
.from("career_profiles")
.select("*")
.eq("user_id",userId)
.single();



const {data:profile}=await client
.from("profiles")
.select("xp,reward_units")
.eq("id",userId)
.single();



const {data:certificates}=await client
.from("certificates")
.select("*")
.eq("user_id",userId);



const box=document.getElementById(
"learner-profile"
);



box.innerHTML=`

<h2>
${career?.name || "Learner"}
</h2>


<p>
${career?.about || ""}
</p>


<h3>
🛠 Skills
</h3>

<p>
${career?.skills || "Not added"}
</p>


<h3>
📁 Projects
</h3>

<p>
${career?.projects || "Not added"}
</p>


<h3>
⭐ Learning Achievements
</h3>


<p>
XP:
${profile?.xp || 0}
</p>


<p>
🎁 Rewards:
${profile?.reward_units || 0}
</p>


<p>
📜 Certificates:
${certificates?.length || 0}
</p>


`;

}


document.addEventListener(
"DOMContentLoaded",
loadLearnerProfile
);
