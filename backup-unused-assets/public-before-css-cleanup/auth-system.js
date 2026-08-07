
async function signUpUser(email,password){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signUp({

email:email,

password:password

});


if(error){

alert(error.message);

return;

}


alert("Account created. Check email verification.");

return data;

}



async function loginUser(email,password){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signInWithPassword({

email:email,

password:password

});


if(error){

alert(error.message);

return;

}


localStorage.setItem(
"user",
JSON.stringify(data.user)
);


window.location.href="/dashboard-router.html";


}



async function logoutUser(){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client.auth.signOut();


localStorage.removeItem("user");


window.location.href="/index.html";

}



async function resetPassword(email){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {error}=await client.auth.resetPasswordForEmail(email);


if(error){

alert(error.message);

return;

}


alert("Password reset email sent.");

}



window.signUpUser=signUpUser;

window.loginUser=loginUser;

window.logoutUser=logoutUser;

window.resetPassword=resetPassword;





