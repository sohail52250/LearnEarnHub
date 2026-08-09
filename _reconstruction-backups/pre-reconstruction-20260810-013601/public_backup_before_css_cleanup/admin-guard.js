

const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

location.href="/login.html";

}


