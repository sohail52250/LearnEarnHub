
async function authRequest(action){


const email=
document.getElementById("email").value;


const password=
document.getElementById("password").value;



const res=await fetch(
"/api/auth",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action,

email,

password

})

});


const data=await res.json();



if(data.error){

document.getElementById("msg").innerText=data.error;

return;

}



if(action==="login"){


const user=
data.user || data;



if(user.id){

localStorage.setItem(
"user_id",
user.id
);


}



if(data.session?.access_token){


localStorage.setItem(
"access_token",
data.session.access_token
);


}



location.href=
"/dashboard-protected.html?user_id="+
(user.id || "");



}else{


document.getElementById("msg").innerText=
"Account created. Login now ✅";


}


}



function login(){

authRequest("login");

}



function signup(){

authRequest("signup");

}



