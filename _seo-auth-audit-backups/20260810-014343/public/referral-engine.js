async function createReferralRecord(
businessId,
learnerId,
referrerId
){

const result = await fetch(
`${SUPABASE_URL}/rest/v1/business_referrals`,
{
method:"POST",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify({

business_id:businessId,
learner_id:learnerId,
referrer_id:referrerId,
status:"pending"

})

});


return await result.json();

}



async function updateReferralStatus(
referralId,
status
){

await fetch(
`${SUPABASE_URL}/rest/v1/business_referrals?id=eq.${referralId}`,
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


window.createReferralRecord =
createReferralRecord;

window.updateReferralStatus =
updateReferralStatus;

