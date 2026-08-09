async function enrollCourse(courseId){

const user =
JSON.parse(localStorage.getItem("user") || "null");


if(!user){
alert("Login required");
return;
}


await fetch(
`${SUPABASE_URL}/rest/v1/course_progress`,
{
method:"POST",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

user_id:user.id,
course_id:courseId,
status:"enrolled",
progress:0

})

});


alert("Course enrolled");

}



async function completeLesson(progressId, courseId){


await fetch(
`${SUPABASE_URL}/rest/v1/course_progress?id=eq.${progressId}`,
{
method:"PATCH",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

status:"completed",
progress:100

})

});


await unlockSkill(courseId);


}



async function unlockSkill(courseId){


const user =
JSON.parse(localStorage.getItem("user") || "null");


const skills={

"excel-basics":"excel",

"digital-marketing":"marketing",

"freelancing":"freelancing",

"communication":"communication"

};



let skill =
skills[courseId];


if(!skill){
return;
}



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



let oldSkills =
profile[0].skills || [];



let updated =
[
...new Set([
...oldSkills,
skill
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

skills:updated,

career_score:
Math.min(updated.length*10,100)

})

});


}



window.enrollCourse=enrollCourse;
window.completeLesson=completeLesson;

