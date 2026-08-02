#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Auth System Setup ==="

mkdir -p public services api



cat > services/auth-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function signup(email,password){

const {data,error}=await db.auth.admin.createUser({

email,

password,

email_confirm:true

});


if(error) throw error;


return data.user;

}



async function login(email,password){

const client=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signInWithPassword({

email,

password

});


if(error) throw error;


return data;

}



module.exports={
signup,
login
};

JS



cat > api/auth.js <<'JS'
const service=require("../services/auth-service");


module.exports=async function(req,res){

try{


if(req.body.action==="signup"){


return res.json(
await service.signup(
req.body.email,
req.body.password
)
);


}



if(req.body.action==="login"){


return res.json(
await service.login(
req.body.email,
req.body.password
)
);


}



res.status(400).json({
error:"Invalid action"
});



}catch(e){

res.status(500).json({
error:e.message
});

}


};

JS



if ! grep -q "/api/auth" server.js
then

cat >> server.js <<'JS'


// Authentication API

const auth=require("./api/auth");

app.post(
"/api/auth",
auth
);

JS

fi



cat > public/login.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Login</title>

<style>

body{
font-family:Arial;
background:#f4f7fb;
padding:30px;
}

.box{
background:white;
max-width:400px;
margin:auto;
padding:20px;
border-radius:12px;
}

input,button{

width:100%;
padding:12px;
margin:8px 0;

}

button{

background:#1565c0;
color:white;
border:0;

}

</style>

</head>


<body>


<div class="box">

<h2>🔐 LearnEarnHub</h2>


<input id="email" placeholder="Email">


<input id="password" type="password" placeholder="Password">


<button onclick="login()">
Login
</button>


<button onclick="signup()">
Create Account
</button>


<p id="msg"></p>


</div>



<script>


async function send(action){


let res=await fetch("/api/auth",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action,

email:email.value,

password:password.value

})

});


let data=await res.json();


msg.innerText=
data.error || "Success ✅";


}



function login(){

send("login");

}


function signup(){

send("signup");

}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Authentication system created"

echo ""
echo "Required .env keys:"
echo "SUPABASE_URL="
echo "SUPABASE_SERVICE_KEY="
echo "SUPABASE_ANON_KEY="

echo ""
echo "Page:"
echo "/login.html"


