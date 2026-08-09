document
.getElementById("businessRegisterForm")
.addEventListener("submit", async function(e){

e.preventDefault();


const email =
document.getElementById("email").value;

const password =
document.getElementById("password").value;


const company =
document.getElementById("company_name").value;


const {data,error}=await supabaseClient.auth.signUp({

email,
password

});


if(error){

document.getElementById("status").innerHTML=
"❌ "+error.message;

return;

}


const user=data.user;


if(user){

const {error:profileError}=await supabaseClient
.from("business_profiles")
.insert({

owner_id:user.id,

company_name:company,

verified:false

});


if(profileError){

document.getElementById("status").innerHTML=
"❌ "+profileError.message;

return;

}


document.getElementById("status").innerHTML=
"✅ Business account created. Redirecting...";


setTimeout(()=>{

location.href="/business-dashboard.html";

},1500);


}

});
