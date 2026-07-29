async function createBusiness(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Login required");

return;

}


await client
.from("business_profiles")
.insert({

user_id:userData.user.id,

company_name:
document.getElementById("company-name").value,

description:
document.getElementById("company-description").value

});


alert("Business profile created");

}


window.createBusiness=createBusiness;
