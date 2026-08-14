

const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

location.href="/auth/sign-in.html";

}


