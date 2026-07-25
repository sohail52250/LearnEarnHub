async function login(){
alert('Login function started');


const email =
document.getElementById("email").value;


const password =
document.getElementById("password").value;



const result =
await supabaseClient.auth.signInWithPassword({

email,
password

});



alert("Login response received");
console.log(result);

if(result.error){

alert(result.error.message);

return;

}



const user =
result.data.user;



localStorage.setItem(
"user",
JSON.stringify(user)
);




const {data:roleData,error:roleError}=await supabaseClient
.from("user_roles")
.select("role")
.eq("user_id",user.id)
.single();

if(roleError){
 alert("Role error: "+roleError.message);
 console.log(roleError);
 return;
}

const role = roleData.role;

console.log("ROLE RESPONSE:", roleData);

if(!roleData.length){

alert("Role not found");

return;

}



const role =
roleData[0].role;



alert("REDIRECTING TO LEARNER DASHBOARD");
if(role==="learner")
location.href="/learner-dashboard.html";


else if(role==="business")
location.href="/business-marketplace.html";


else if(role==="sponsor")
location.href="/sponsor-dashboard.html";


else if(role==="referral")
location.href="/referral-manager-dashboard.html";


else if(role==="admin")
location.href="/admin-control-center.html";


else
location.href="/index.html";


}


window.login=login;
