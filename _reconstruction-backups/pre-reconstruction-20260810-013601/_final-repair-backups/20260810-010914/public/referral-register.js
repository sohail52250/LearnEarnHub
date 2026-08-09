
function getReferralCode(){

const params =
new URLSearchParams(
window.location.search
);

return params.get("ref");

}


async function saveReferral(referredUserId){

const code=getReferralCode();

if(!code) return;

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:referrer}=await client
.from("referral_codes")
.select("*")
.eq("referral_code",code)
.single();

if(!referrer) return;


await client
.from("referrals")
.insert({

referrer_user_id:
referrer.user_id,

referred_user_id:
referredUserId

});

}

window.saveReferral = saveReferral;

