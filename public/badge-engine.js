async function createSkillBadge(courseId){

const user =
JSON.parse(localStorage.getItem("user") || "null");


if(!user){
return;
}


const course =
await fetch(
`${SUPABASE_URL}/rest/v1/courses?id=eq.${courseId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
)
.then(r=>r.json());


if(!course.length){
return;
}



const rewards =
course[0].skill_reward || [];



for(const skill of rewards){


await fetch(
`${SUPABASE_URL}/rest/v1/learner_badges`,
{
method:"POST",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

user_id:user.id,

skill:skill,

badge_name:
"Certified "+skill+" Skill"

})

});

}


await updateLearnerSkills(rewards);

}



async function updateLearnerSkills(newSkills){


const user =
JSON.parse(localStorage.getItem("user") || "null");



const profile =
await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles?user_id=eq.${user.id}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
)
.then(r=>r.json());



if(!profile.length){
return;
}



const oldSkills =
profile[0].skills || [];



const skills =
[
...new Set([
...oldSkills,
...newSkills
])
];



await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles?user_id=eq.${user.id}`,
{
method:"PATCH",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

skills:skills,

career_score:
Math.min(skills.length*10,100)

})

});


}



window.createSkillBadge=createSkillBadge;

