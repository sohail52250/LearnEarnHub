
async function checkSession(){

const token=
localStorage.getItem("access_token");


if(!token){

location.href="/login.html";

return false;

}


return true;

}



function logout(){

localStorage.removeItem("access_token");

localStorage.removeItem("user_id");

location.href="/login.html";

}


