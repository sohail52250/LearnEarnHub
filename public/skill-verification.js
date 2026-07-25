async function getLearnerVerification(userId){

const badges =
await fetch(
`${SUPABASE_URL}/rest/v1/learner_badges?user_id=eq.${userId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
)
.then(r=>r.json());


return badges;

}



async function requestSkillVerification(
learnerId,
businessId
){

await fetch(
`${SUPABASE_URL}/rest/v1/skill_verifications`,
{
method:"POST",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

learner_id:learnerId,

business_id:businessId,

status:"requested"

})

});

}



window.getLearnerVerification =
getLearnerVerification;

window.requestSkillVerification =
requestSkillVerification;

