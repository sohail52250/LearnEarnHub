function redirectByRole(){

const role=localStorage.getItem("role");

switch(role){

case "admin":
 location.href="/admin-dashboard.html";
 break;

case "business":
 location.href="/business-dashboard.html";
 break;

case "instructor":
 location.href="/instructor-dashboard.html";
 break;

default:
 location.href="/student-dashboard.html";

}

}
