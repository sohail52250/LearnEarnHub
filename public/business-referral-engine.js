async function createBusinessLead(data){

return await fetch(
`${SUPABASE_URL}/rest/v1/business_referrals`,
{
method:"POST",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

business_name:data.business_name,

business_category:data.category,

contact_info:data.contact,

referrer_id:data.referrer_id,

status:"pending"

})

})
.then(r=>r.json());

}



async function getMyReferrals(userId){

return await fetch(
`${SUPABASE_URL}/rest/v1/business_referrals?referrer_id=eq.${userId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());

}



async function updateReferralStatus(id,status){

await fetch(
`${SUPABASE_URL}/rest/v1/business_referrals?id=eq.${id}`,
{
method:"PATCH",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

status:status

})

});

}



window.createBusinessLead=createBusinessLead;
window.getMyReferrals=getMyReferrals;
window.updateReferralStatus=updateReferralStatus;

