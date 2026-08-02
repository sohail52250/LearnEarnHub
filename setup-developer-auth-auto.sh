#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating developer auth middleware ==="

mkdir -p middleware

cat > middleware/developer-auth.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res,next)=>{

 try{

 const token=req.headers.authorization?.replace("Bearer ","");

 if(!token){
  return res.status(401).json({
   error:"Missing login token"
  });
 }

 const {data,error}=await db.auth.getUser(token);

 if(error || !data.user){
  return res.status(401).json({
   error:"Invalid session"
  });
 }

 req.user=data.user;

 next();

 }catch(e){

 res.status(500).json({
  error:e.message
 });

 }

};
JS


cat > public/developer/login.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Developer Login</title>
</head>
<body>

<h2>LearnEarnHub Developer Login</h2>

<input id="email" placeholder="Email">
<input id="password" type="password" placeholder="Password">

<button onclick="login()">Login</button>

<p id="msg"></p>

<script type="module">

import {createClient}
from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

const supabase=createClient(
 "YOUR_SUPABASE_URL",
 "YOUR_SUPABASE_ANON_KEY"
);


window.login=async()=>{

 const email=document.getElementById("email").value;
 const password=document.getElementById("password").value;

 const {data,error}=await supabase.auth.signInWithPassword({
  email,
  password
 });

 if(error){
  msg.innerHTML=error.message;
  return;
 }

 localStorage.setItem(
 "LEH_SESSION",
 data.session.access_token
 );

 location="/developer/dashboard.html";

}

</script>

</body>
</html>
HTML


git add .
git commit -m "Add Supabase developer authentication"
git push

echo "=== Done ==="
