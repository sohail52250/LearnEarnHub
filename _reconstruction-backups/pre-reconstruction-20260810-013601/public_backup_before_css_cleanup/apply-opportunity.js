async function applyOpportunity(opportunityId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;


const {error}=await client
.from("applications")
.insert({

opportunity_id: opportunityId,

applicant_id:userData.user.id,

status:"pending",

created_at:new Date()

});


alert(
error ?
"Application failed"
:
"Application submitted"
);

}


window.applyOpportunity=applyOpportunity;
