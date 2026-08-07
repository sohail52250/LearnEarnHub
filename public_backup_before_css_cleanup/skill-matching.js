async function loadSkillRecommendations(){

const skillResponse =
await fetch("/data/skill-map.json");

const skills =
await skillResponse.json();


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;


const {data:progress}=await client
.from("lesson_progress")
.select("*")
.eq("user_id",userData.user.id);


let recommendations=[];


(progress || []).forEach(item=>{

const course=
item.course_slug;


if(skills[course]){

recommendations.push({

skill:skills[course].skill,

jobs:skills[course].jobs

});

}

});


const box=document.getElementById(
"skill-recommendations"
);


if(box){

if(recommendations.length===0){

box.innerHTML=`

<p>
Complete lessons to unlock career opportunities.
</p>

`;

return;

}


box.innerHTML=`

<h2>💼 Recommended Opportunities</h2>

${recommendations.map(r=>`

<div class="card">

<h3>
${r.skill}
</h3>

<p>
Possible paths:
</p>

<ul>

${r.jobs.map(j=>
`<li>${j}</li>`
).join("")}

</ul>

</div>

`).join("")}

`;

}


}


document.addEventListener(
"DOMContentLoaded",
loadSkillRecommendations
);
