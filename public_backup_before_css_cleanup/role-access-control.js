
function redirectByRole(role){

switch(role){

case "learner":

window.location.href="/learner-dashboard.html";
break;


case "seller":

window.location.href="/seller-dashboard.html";
break;


case "business":

window.location.href="/business-dashboard.html";
break;


case "investor":

window.location.href="/investor-profile.html";
break;


case "admin":

window.location.href="/admin-control-dashboard.html";
break;


default:

window.location.href="/account-center.html";

}

}



function getCurrentUser(){

const user =
localStorage.getItem("user");


if(!user){

window.location.href="/login.html";

return null;

}


return JSON.parse(user);

}



window.redirectByRole=redirectByRole;

window.getCurrentUser=getCurrentUser;

