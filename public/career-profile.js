async function saveCareerProfile(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user)return;



await client
.from("career_profiles")
.upsert({

user_id:userData.user.id,

name:
document.getElementById("career-name").value,

about:
document.getElementById("career-about").value,

skills:
document.getElementById("career-skills").value,

projects:
document.getElementById("career-projects").value

});



document.getElementById("message")
.innerHTML=
"Profile saved successfully";

}



async function loadAchievements(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user)return;


const {data:profile}=await client
.from("profiles")
.select("xp,reward_units")
.eq("id",userData.user.id)
.single();



document.getElementById(
"achievements"
).innerHTML=

`

⭐ XP:
${profile?.xp || 0}

<br>

🎁 Rewards:
${profile?.reward_units || 0}

<br>

🏅 Verified learner

`;

}



document.addEventListener(
"DOMContentLoaded",
loadAchievements
);


window.saveCareerProfile=
saveCareerProfile;
