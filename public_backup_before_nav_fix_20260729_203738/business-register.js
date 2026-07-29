async function saveBusiness(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;


const business={

user_id:userData.user.id,

business_name:
document.getElementById("business-name").value,

business_type:
document.getElementById("business-type").value,

industry:
document.getElementById("industry").value,

description:
document.getElementById("description").value,

website:
document.getElementById("website").value,

contact:
document.getElementById("contact").value,

verified:false,
verification_status:"pending",
verification_type:"referral",
trust_score:0

};



const {error}=await client
.from("business_profiles")
.insert(business);



document.getElementById("message")
.innerHTML =
error ?
"Error creating profile"
:
"Business profile created successfully";

}


window.saveBusiness=saveBusiness;
