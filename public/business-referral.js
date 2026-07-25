async function createBusinessReferral(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user)return;


const businessName =
document.getElementById("business-name").value;


const category =
document.getElementById("category").value;



const {data:business}=await client
.from("business_profiles")
.insert({

owner_id:null,

business_name:businessName,

category:category,

verified:false,

verification_type:"referral_pending",

created_at:new Date()

})
.select()
.single();



if(business){


await client
.from("business_referrals")
.insert({

business_id:business.id,

referrer_user_id:userData.user.id,

status:"pending",

created_at:new Date()

});


alert(
"Business referral submitted"
);


}


}


window.createBusinessReferral=
createBusinessReferral;
