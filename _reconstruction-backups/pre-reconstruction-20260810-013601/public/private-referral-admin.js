async function loadAdminReferrals(){

const data =
await fetch(
`${SUPABASE_URL}/rest/v1/business_referrals`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());


return data;

}


window.loadAdminReferrals =
loadAdminReferrals;
