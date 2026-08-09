async function login(email,password){

let r=await fetch("/api/auth",{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({
action:"login",
email,
password
})
});

let result=await r.json();

if(result.success){

localStorage.setItem(
"user_id",
result.user.id
);

localStorage.setItem(
"token",
result.token
);

}

return result;

}
