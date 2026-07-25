async function loadCareerProfile(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;


const userId=userData.user.id;


const {data:profile}=await client
.from("profiles")
.select("xp,reward_units")
.eq("id",userId)
.single();



const {data:lessons}=await client
.from("lesson_progress")
.select("*")
.eq("user_id",userId);



const {data:certificates}=await client
.from("certificates")
.select("*")
.eq("user_id",userId);



const completedLessons =
lessons ? lessons.length : 0;


const certificateCount =
certificates ? certificates.length : 0;


const xp =
profile?.xp || 0;


let readiness="Beginner";

if(xp>=500){
readiness="Skill Builder";
}

if(xp>=1000){
readiness="Career Ready";
}


const box=document.getElementById(
"career-card"
);


if(box){

box.innerHTML=`

<h2>
🏅 ${readiness}
</h2>


<p>
⭐ XP:
${xp}
</p>


<p>
📚 Completed Lessons:
${completedLessons}
</p>


<p>
📜 Certificates:
${certificateCount}
</p>


<h3>
Verified Skills
</h3>


<ul>

${completedLessons > 0
?
"<li>Digital Learning Progress Verified</li>"
:
"<li>Start learning to unlock skills</li>"
}

</ul>


`;

}


}


document.addEventListener(
"DOMContentLoaded",
loadCareerProfile
);
