(function(){

const path = location.pathname;

const protectedPages = {

"/admin-dashboard.html":"admin",
"/admin-control-center.html":"admin",

"/instructor-dashboard.html":"instructor",
"/instructor-course.html":"instructor",

"/business-dashboard.html":"business",
"/business-dashboard-v2.html":"business",
"/business-profile-complete.html":"business",

"/student-dashboard.html":"learner",
"/learner-dashboard-v2.html":"learner"

};


const requiredRole = protectedPages[path];

if(!requiredRole) return;


let user=null;

try{
 user=JSON.parse(localStorage.getItem("user"));
}catch(e){}


if(!user){

 alert("Please login first");
 location.href="/login.html";
 return;

}


if(user.role!==requiredRole && user.role!=="admin"){

 alert("Access denied");
 location.href="/index.html";

}


})();
