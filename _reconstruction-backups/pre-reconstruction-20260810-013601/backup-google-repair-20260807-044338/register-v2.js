
async function registerUser(){

const name =
document.getElementById("name").value;


const email =
document.getElementById("email").value;


const role =
document.getElementById("role").value;



const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:user,error:userError} =
await client
.from("user_profiles")
.insert({

full_name:name,

profile_type:role

})
.select()
.single();



if(userError){

console.log(userError);

return;

}



await client
.from("user_roles")
.insert({

user_id:user.user_id,

role_name:role

});



await client
.from("onboarding_progress")
.insert({

user_id:user.user_id,

account_type:role,

step:"registration_completed"

});



localStorage.setItem(
"user",
JSON.stringify({

id:user.user_id,

role:role

})
);



window.location.href="/dashboard-router.html";


}



window.registerUser=registerUser;

