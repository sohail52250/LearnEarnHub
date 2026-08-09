async function loadSponsoredOpportunities(){

const data = await fetch(
`${SUPABASE_URL}/rest/v1/opportunities?type=eq.sponsored`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());


return data;

}


async function submitSponsorOpportunity(data){

return await fetch(
`${SUPABASE_URL}/rest/v1/opportunities`,
{
method:"POST",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

title:data.title,
description:data.description,
required_skills:data.skills,
earning_type:"sponsored",
type:"sponsored"

})

})
.then(r=>r.json());

}


window.loadSponsoredOpportunities =
loadSponsoredOpportunities;

window.submitSponsorOpportunity =
submitSponsorOpportunity;

