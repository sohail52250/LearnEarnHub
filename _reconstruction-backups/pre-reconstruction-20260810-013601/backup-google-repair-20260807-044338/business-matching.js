async function findBusinessMatches(requiredSkills){

const learners = await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());


let results=[];


learners.forEach(learner=>{

let skills =
learner.skills || [];


let matched =
requiredSkills.filter(
s=>skills.includes(s)
);


let score =
requiredSkills.length
?
Math.round(
(matched.length / requiredSkills.length)*100
)
:0;


if(score>0){

results.push({

name:learner.full_name,
score:score,
skills:skills

});

}

});


return results.sort(
(a,b)=>b.score-a.score
);

}


window.findBusinessMatches =
findBusinessMatches;
