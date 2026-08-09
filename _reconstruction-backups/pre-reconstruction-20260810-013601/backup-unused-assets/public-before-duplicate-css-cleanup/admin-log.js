async function adminLog(action,details){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:{user}} =
await client.auth.getUser();


if(!user){
return;
}


await client

.from("admin_activity_logs")

.insert({

admin_id:user.id,

action:action,

details:details

});


}

