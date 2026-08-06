
async function checkAdmin(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Please login first");

window.location="/login.html";

return;

}


const {data}=await client

.from("profiles")

.select("role")

.eq("id",userData.user.id)

.single();


if(!data || data.role!=="admin"){

alert("Admin access required");

window.location="/student-dashboard.html";

return;

}


console.log("Admin verified");


}


document.addEventListener(
"DOMContentLoaded",
checkAdmin
);

