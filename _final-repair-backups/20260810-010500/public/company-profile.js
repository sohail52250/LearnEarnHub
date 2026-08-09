
async function createCompanyProfile(data){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:result,error}=await client
.from("company_profiles")
.insert(data)
.select();


if(error){

console.log(error);
return null;

}


return result;

}


window.createCompanyProfile =
createCompanyProfile;

