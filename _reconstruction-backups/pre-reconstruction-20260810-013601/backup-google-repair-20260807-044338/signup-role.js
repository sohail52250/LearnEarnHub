async function signup(){


const email =
document.getElementById("email").value;


const password =
document.getElementById("password").value;


const role =
document.getElementById("role").value;



const response =
await supabase.auth.signUp({

email,
password

});


if(response.error){

alert(response.error.message);

return;

}



const user =
response.data.user;



await fetch(
`${SUPABASE_URL}/rest/v1/user_roles`,
{

method:"POST",

headers:{

apikey:SUPABASE_KEY,

Authorization:
`Bearer ${SUPABASE_KEY}`,

"Content-Type":"application/json"

},

body:JSON.stringify({

user_id:user.id,

role:role

})

});



if(role==="learner")
location.href="/learner-dashboard.html";


if(role==="business")
location.href="/business-marketplace.html";


if(role==="sponsor")
location.href="/sponsor-dashboard.html";


if(role==="referral")
location.href="/referral-manager-dashboard.html";



}


window.signup=signup;
