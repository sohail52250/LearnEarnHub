async function findLearnersForBusiness(requiredSkills){


const learners =
await fetch(
`${SUPABASE_URL}/rest/v1/learner_profiles`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());



return learners.map(learner=>{


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
(matched.length /
requiredSkills.length)*100
)
:0;



return {

...learner,

match_score:score

};


})
.sort(
(a,b)=>
b.match_score-a.match_score
);


}



async function sendContactRequest(
learnerId,
businessId
){


await fetch(
`${SUPABASE_URL}/rest/v1/contact_requests`,
{

method:"POST",

headers:{

apikey:SUPABASE_KEY,

Authorization:
`Bearer ${SUPABASE_KEY}`,

"Content-Type":"application/json"

},

body:JSON.stringify({

learner_id:learnerId,

business_id:businessId,

status:"pending"

})

});


}



window.findLearnersForBusiness =
findLearnersForBusiness;


window.sendContactRequest =
sendContactRequest;

