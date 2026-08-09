
async function saveProfile(data){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:result,error}=await client
.from("profile_details")
.insert(data)
.select();


if(error){

console.log(error);

return null;

}


return result;

}



async function submitVerification(data){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


return await client
.from("user_verification_requests")
.insert(data);

}



window.saveProfile=saveProfile;

window.submitVerification=submitVerification;

