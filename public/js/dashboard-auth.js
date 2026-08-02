
async function loadUser(){

const {data}=await supabaseClient.auth.getUser();


if(!data.user){

location.href="/login.html";

return;

}


document.getElementById("user-email").innerHTML =
data.user.email;


}

loadUser();

