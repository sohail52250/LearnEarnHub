async function registerUser(){

const name=document.getElementById("name").value;
const email=document.getElementById("email").value;
const password=document.getElementById("password").value;


const {createClient}=supabase;

const client=createClient(
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
alert("Account created successfully!");

window.location="/auth/sign-in.html";

}



async function loginUser(){

const email=document.getElementById("email").value;
const password=document.getElementById("password").value;


const client=supabase.createClient(
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


window.location="/student-dashboard.html";

}



async function logoutUser(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client.auth.signOut();

window.location="/auth/sign-in.html";

}
