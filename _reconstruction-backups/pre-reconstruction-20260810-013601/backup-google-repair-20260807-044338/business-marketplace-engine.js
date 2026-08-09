async function loadBusinessOffers(){

const offers = await fetch(
`${SUPABASE_URL}/rest/v1/business_offers`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
})
.then(r=>r.json());


return offers;

}


async function createBusinessOffer(data){

return await fetch(
`${SUPABASE_URL}/rest/v1/business_offers`,
{
method:"POST",
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`,
"Content-Type":"application/json"
},
body:JSON.stringify(data)

})
.then(r=>r.json());

}


window.loadBusinessOffers =
loadBusinessOffers;

window.createBusinessOffer =
createBusinessOffer;
