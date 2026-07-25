
async function checkAdminAccess(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:{user}} =
await client.auth.getUser();


if(!user){

location.href="/login.html";

return;

}


const {data:roleData,error}=await client

.from("user_roles")

.select("role")

.eq("user_id",user.id)

.single();



if(error || !roleData || roleData.role!=="admin"){


document.body.innerHTML=`

<div class="card">

<h1>
🚫 Access Denied
</h1>

<p>
Admin permission required.
</p>

<a href="/index.html">
Return Home
</a>

</div>

`;


return false;

}



return true;


}



