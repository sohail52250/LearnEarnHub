async function postJob(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Please login first");

return;

}


const {data:business}=await client
.from("business_profiles")
.select("id")
.eq("user_id",userData.user.id)
.single();


if(!business){

alert("Please create a business profile first");

return;

}


const {error}=await client
.from("jobs")
.insert({

business_id:business.id,

title:
document.getElementById("job-title").value,

description:
document.getElementById("job-description").value,

skills_required:
document.getElementById("job-skills").value,

location:
document.getElementById("job-location").value,

type:"job",

status:"active"

});


if(error){

alert(error.message);

return;

}


alert("Opportunity published successfully");

}


window.postJob=postJob;
