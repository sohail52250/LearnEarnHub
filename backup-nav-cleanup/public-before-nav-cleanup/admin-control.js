async function loadPendingBusinesses(){

return await fetch(
`${SUPABASE_URL}/rest/v1/business_profiles?verified=eq.false`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());

}



async function verifyBusiness(id){

await fetch(
`${SUPABASE_URL}/rest/v1/business_profiles?id=eq.${id}`,
{
method:"PATCH",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({
verified:true
})
});

}



async function loadSponsoredPending(){

return await fetch(
`${SUPABASE_URL}/rest/v1/opportunities?type=eq.sponsored`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());

}



window.loadPendingBusinesses =
loadPendingBusinesses;

window.verifyBusiness =
verifyBusiness;

window.loadSponsoredPending =
loadSponsoredPending;
