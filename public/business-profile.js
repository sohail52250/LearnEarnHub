async function createBusiness(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:user}=await client.auth.getUser();


if(!user.user) return;


await client
.from("business_profiles")
.insert({

user_id:user.user.id,

company_name:
document.getElementById("company-name").value,

description:
document.getElementById("company-description").value

});


alert("Business profile created");

}


window.createBusiness=createBusiness;
