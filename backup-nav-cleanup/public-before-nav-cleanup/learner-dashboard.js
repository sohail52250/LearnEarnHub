
async function loadLearnerDashboard(){

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



document.getElementById("dashboard").innerHTML=`

<div class="card">

<h1>
🎓 Welcome Learner
</h1>

<p>
${user.email}
</p>

<h2>
Level ${stats?.level || 1}
</h2>


<p>
⭐ XP:
${stats?.xp || 0}
</p>


<div>

Progress

<br>

████████░░

</div>


</div>



<div class="card">

<h2>
📚 Learning Progress
</h2>


<p>
Completed Courses:
${stats?.completed_courses || 0}
</p>


<p>
Learning Hours:
${stats?.learning_hours || 0}
</p>


<p>
Certificates:
${stats?.certificates || 0}
</p>


</div>



<div class="card">

<h2>
🛠 Skills
</h2>


${
skills?.map(
s=>`
<p>
✅ ${s.skill}
-
${s.level}
</p>
`
).join("")
||
"No skills added"
}


</div>



<div class="card">

<h2>
🏆 Achievements
</h2>


${
badges?.map(
b=>`
<p>
🏅 ${b.badge_name}
</p>
`
).join("")
||
"Complete courses to earn badges"
}


</div>



<div class="card">

<h2>
🚀 Career Roadmap
</h2>


<p>
Learn → Practice → Build Projects → Earn Certificates → Find Opportunities
</p>


<a href="/courses.html">

<button>
Explore Courses
</button>

</a>


</div>


`;

}


document.addEventListener(
"DOMContentLoaded",
loadLearnerDashboard
);

