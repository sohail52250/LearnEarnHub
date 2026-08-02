#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating developer login protection ==="

mkdir -p public/developer

cat > public/developer/login.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Developer Login - LearnEarnHub</title>
</head>
<body>

<h2>Developer Portal Login</h2>

<input id="key" placeholder="Developer API Key">
<button onclick="login()">Login</button>

<p id="msg"></p>

<script>

function login(){

 let key=document.getElementById("key").value;

 if(key){

  localStorage.setItem("LEH_DEV_KEY",key);

  window.location="/developer/dashboard.html";

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

<div id="content"></div>

<script>

const key=localStorage.getItem("LEH_DEV_KEY");

if(!key){
 window.location="/developer/login.html";
}

async function load(){

const r=await fetch(
"/api/developer/key-control"
);

const data=await r.json();

document.getElementById("content").innerHTML=
JSON.stringify(data,null,2);

}

load();

</script>

</body>
</html>
HTML


git add .
git commit -m "Add developer portal login protection"
git push

echo "=== Completed ==="
