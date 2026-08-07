
async function login(){

const email=document.getElementById("email").value;
const password=document.getElementById("password").value;

const {data,error}=await supabaseClient.auth.signInWithPassword({
email,
password
});

if(error){
alert(error.message);
return;
}

const user=data.user;

console.log("LOGIN OK:",user.id);

localStorage.setItem("user",JSON.stringify(user));

const {data:roleData,error:roleError}=await supabaseClient
.from("user_roles")
.select("role")
.eq("user_id",user.id)
.maybeSingle();

console.log("ROLE:",roleData,roleError);

if(roleError){
alert("Role error: "+roleError.message);
return;
}

if(!roleData){
alert("Role not found");
return;
}

if(roleData.role==="learner"){
window.location.href="/learner-dashboard.html";
}
else if(roleData.role==="business"){
window.location.href="/business-dashboard.html";
}
else if(roleData.role==="admin"){
window.location.href="/admin-control-center.html";
}
else{
window.location.href="/index.html";
}

}
