#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Auth Redirect Setup ==="

mkdir -p public/js



cat > public/js/login-handler.js <<'JS'

async function authRequest(action){


const email=
document.getElementById("email").value;


const password=
document.getElementById("password").value;



const res=await fetch(
"/api/auth",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action,

email,

password

})

});


const data=await res.json();



if(data.error){

document.getElementById("msg").innerText=data.error;

return;

}



if(action==="login"){


const user=
data.user || data;



if(user.id){

localStorage.setItem(
"user_id",
user.id
);


}



if(data.session?.access_token){


localStorage.setItem(
"access_token",
data.session.access_token
);


}



location.href=
"/dashboard-protected.html?user_id="+
(user.id || "");



}else{


document.getElementById("msg").innerText=
"Account created. Login now ✅";


}


}



function login(){

authRequest("login");

}



function signup(){

authRequest("signup");

}



JS




python3 - <<'PY'

p="public/login.html"

try:

s=open(p).read()

s=s.replace(
"</body>",
'<script src="/js/login-handler.js"></script></body>'
)

open(p,"w").write(s)

print("login.html updated")

except Exception as e:

print(e)

PY



cat > services/profile-sync.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createProfile(user){


const {error}=await db
.from("profiles")
.upsert({

user_id:user.id,

full_name:user.email?.split("@")[0] || "Learner"

});



if(error) throw error;


return true;

}



module.exports={
createProfile
};

JS



node -c server.js


echo ""
echo "✅ Auth redirect system completed"

echo ""
echo "Added:"
echo "Login → Save session"
echo "Login → Redirect dashboard"
echo "Profile sync service"


