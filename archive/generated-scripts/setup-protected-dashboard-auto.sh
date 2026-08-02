#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Protected Dashboard Setup ==="

mkdir -p public/js middleware



cat > public/js/auth-session.js <<'JS'

async function checkSession(){

const token=
localStorage.getItem("access_token");


if(!token){

location.href="/login.html";

return false;

}


return true;

}



function logout(){

localStorage.removeItem("access_token");

localStorage.removeItem("user_id");

location.href="/login.html";

}


JS



cat > middleware/auth.js <<'JS'

function auth(req,res,next){


const token=
req.headers.authorization;


if(!token){

return res.status(401).json({

error:"Unauthorized"

});

}


next();


}


module.exports=auth;

JS



if ! grep -q "auth middleware" server.js
then

cat >> server.js <<'JS'


// Protected API middleware

const authMiddleware=require("./middleware/auth");


app.get(
"/api/protected-dashboard",
authMiddleware,
(req,res)=>{

res.json({

success:true,

message:"Protected dashboard access"

});

});


JS

fi



cat > public/dashboard-protected.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Dashboard</title>

<script src="/js/auth-session.js"></script>

<style>

body{

font-family:Arial;
background:#f5f7fb;
padding:20px;

}

.card{

background:white;
padding:20px;
border-radius:12px;

}

button{

padding:10px;
background:#d32f2f;
color:white;
border:0;

}

</style>

</head>


<body onload="checkSession()">


<div class="card">


<h1>
🎓 LearnEarnHub Dashboard
</h1>


<p>
Welcome Learner
</p>


<button onclick="logout()">
Logout
</button>


</div>



</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Protected dashboard created"

echo ""
echo "Files:"
echo "public/dashboard-protected.html"
echo "public/js/auth-session.js"
echo "middleware/auth.js"


