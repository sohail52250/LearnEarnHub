function calculateMatch(
learner,
opportunity
){

let score = 0;


let learnerSkills =
learner.skills || [];


let required =
opportunity.required_skills || [];



let skillMatches =
required.filter(
s=>learnerSkills.includes(s)
);



if(required.length){

score +=
(skillMatches.length / required.length) * 60;

}



if(
learner.location &&
opportunity.location &&
learner.location === opportunity.location
){

score += 20;

}



if(
learner.career_score
){

score +=
Math.min(
learner.career_score * 0.2,
20
);

}



return Math.round(score);

}




async function findBestOpportunities(userId){


const learner =
await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles?user_id=eq.${userId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
)
.then(r=>r.json());



const opportunities =
await fetch(
`${SUPABASE_URL}/rest/v1/opportunities`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
)
.then(r=>r.json());



if(!learner.length)
return [];



return opportunities.map(o=>({

...o,

match_score:
calculateMatch(
learner[0],
o
)

}))
.sort(
(a,b)=>
b.match_score-a.match_score
);


}



window.findBestOpportunities =
findBestOpportunities;

