async function findOpportunityMatches(userId){

const profile = await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles?user_id=eq.${userId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}).then(r=>r.json());


if(!profile.length){
return [];
}


const skills = profile[0].skills || [];


const opportunities = await fetch(
`${SUPABASE_URL}/rest/v1/opportunities`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}).then(r=>r.json());


let matches=[];


opportunities.forEach(opportunity=>{

let required = opportunity.required_skills || [];

let matched = required.filter(
skill=>skills.includes(skill)
);


let score = required.length
? Math.round((matched.length / required.length)*100)
:0;


if(score>0){

matches.push({
opportunity_id:opportunity.id,
title:opportunity.title,
score:score
});

}

});


return matches.sort(
(a,b)=>b.score-a.score
);

}


window.findOpportunityMatches=findOpportunityMatches;
