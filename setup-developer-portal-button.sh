#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating Developer Portal UI ==="

mkdir -p public/developer

cat > public/developer/login.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Developer Portal</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
body{font-family:Arial;padding:30px}
.card{max-width:400px;margin:auto;padding:20px;border:1px solid #ddd;border-radius:10px}
button{width:100%;padding:12px}
input{width:100%;padding:10px;margin:8px 0}
</style>
</head>
<body>

<div class="card">
<h2>Developer Portal</h2>

<p>Enter your developer session token</p>

<input id="token" placeholder="Session token">

<button onclick="login()">Access Dashboard</button>

<p id="msg"></p>
</div>

<script>
async function login(){

let token=document.getElementById("token").value;

let r=await fetch("/api/developer/secure-dashboard",{
headers:{
"x-session-token":token
}
});

let data=await r.json();

if(data.error){
document.getElementById("msg").innerText=data.error;
}else{
localStorage.setItem("dev_token",token);
location.href="/developer/dashboard.html";
}

}
</script>

</body>
</html>
HTML


cat > public/developer/dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Developer Dashboard</title>
</head>
<body>

<h1>LearnEarnHub Developer Dashboard</h1>

<pre id="data">Loading...</pre>

<script>

fetch("/api/developer/secure-dashboard",{
headers:{
"x-session-token":localStorage.getItem("dev_token")
}
})
.then(r=>r.json())
.then(d=>{
document.getElementById("data").innerText=
JSON.stringify(d,null,2)
})

</script>

</body>
</html>
HTML


git add .
git commit -m "Create developer portal login and dashboard UI"
git push

vercel --prod

echo "=== Developer Portal Ready ==="

