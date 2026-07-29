async function createBusinessLead(data){

return await fetch(
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


status:"pending"

})

})
.then(r=>r.json());

}



async function getMyReferrals(userId){

return await fetch(
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

