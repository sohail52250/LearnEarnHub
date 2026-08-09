
async function rewardReferral(referralId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:referral}=await client
.from("referrals")
.select("*")
.eq("id",referralId)
.single();


if(!referral) return;


if(referral.rewarded){

return;

}


const {data:profile}=await client
.from("profiles")
.select("xp,reward_units")
.eq("id",referral.referrer_user_id)
.single();


if(!profile) return;


await client
.from("profiles")
.update({

xp:(profile.xp || 0)+50,

reward_units:(profile.reward_units || 0)+100

})
.eq("id",referral.referrer_user_id);



await client
.from("referrals")
.update({

rewarded:true

})
.eq("id",referralId);


}

window.rewardReferral=rewardReferral;

