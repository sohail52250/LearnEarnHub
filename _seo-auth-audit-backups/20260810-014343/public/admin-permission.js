
async function getAdminLevel(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:{user}} =
await client.auth.getUser();


if(!user){
return null;
}



const {data}=await client

.from("admin_roles")

.select("admin_level")

.eq("user_id",user.id)

.single();



return data?.admin_level || null;


}



async function requirePermission(permission){


const level =
await getAdminLevel();



if(level==="super_admin"){
return true;
}



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data}=await client

.from("admin_permissions")

.select("*")

.eq("admin_level",level)

.eq("permission",permission);



return data && data.length>0;


}

