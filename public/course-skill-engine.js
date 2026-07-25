const COURSE_SKILLS = {

"excel-basics":[
"excel",
"data_entry"
],

"typing-mastery":[
"typing",
"documentation"
],

"digital-marketing":[
"marketing",
"social_media"
],

"freelancing-start":[
"freelancing",
"client_handling"
],

"ms-office":[
"ms_office",
"office_work"
]

};


async function unlockCourseSkill(userId, courseId){

let newSkills =
COURSE_SKILLS[courseId] || [];


if(!newSkills.length){
return;
}


const profile = await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles?user_id=eq.${userId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
).then(r=>r.json());


if(!profile.length){
return;
}


let oldSkills =
profile[0].skills || [];


let updatedSkills =
[
...new Set([
...oldSkills,
...newSkills
])
];


let score =
Math.min(updatedSkills.length * 10,100);



await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles?user_id=eq.${userId}`,
{
method:"PATCH",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

skills:updatedSkills,
career_score:score

})
});


return updatedSkills;

}


window.unlockCourseSkill =
unlockCourseSkill;

