async function getReferralScore(userId){

return await fetch(
`${SUPABASE_URL}/rest/v1/referral_scores?referrer_id=eq.${userId}`,
{
headers:{
apikey:SUPABASE_KEY,
Authorization:`Bearer ${SUPABASE_KEY}`
}
}
).then(r=>r.json());

}


window.getReferralScore =
getReferralScore;
