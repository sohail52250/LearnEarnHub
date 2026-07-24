function registerUser(){

let name=document.getElementById("name").value;
let email=document.getElementById("email").value;
let password=document.getElementById("password").value;


if(!name || !email || !password){

alert("Please complete all fields");
return;

}


let user={

name:name,
email:email,
password:password

};


localStorage.setItem(
"learnEarnUser",
JSON.stringify(user)
);


alert("Account created successfully!");

window.location="/student-dashboard.html";

}



function loginUser(){

let email=document.getElementById("email").value;
let password=document.getElementById("password").value;


let user=JSON.parse(
localStorage.getItem("learnEarnUser")
);


if(user && user.email===email && user.password===password){

alert("Login successful!");

window.location="/student-dashboard.html";

}

else{

alert("Incorrect email or password");

}

}



function showUser(){

let user=JSON.parse(
localStorage.getItem("learnEarnUser")
);


if(user){

let box=document.getElementById("username");

if(box){

box.innerHTML=
"Welcome "+user.name;

}

}

}
