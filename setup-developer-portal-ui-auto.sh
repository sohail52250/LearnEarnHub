#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating Developer Portal UI ==="

mkdir -p public/developer

cat > public/developer/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Developer Portal</title>
<style>
body{font-family:Arial;padding:20px}
button{padding:8px;margin:5px}
.card{border:1px solid #ddd;padding:15px;margin:10px 0;border-radius:8px}
</style>
</head>

<body>

<h1>LearnEarnHub Developer Portal</h1>

<div id="keys"></div>

<script>

async function loadKeys(){

 const r=await fetch("/api/developer/key-control");
 const data=await r.json();

 const box=document.getElementById("keys");
 box.innerHTML="";

 data.keys.forEach(k=>{

  box.innerHTML+=`

  <div class="card">

  <b>${k.name}</b><br>

  Key:
  ${k.api_key}<br>

  Status:
  ${k.status || "active"}<br>

  Blocked:
  ${k.blocked || false}

  <br>

  <button onclick="regenerate(${k.id})">
  Regenerate
  </button>

  <button onclick="toggle(${k.id},'block')">
  Block
  </button>

  <button onclick="toggle(${k.id},'unblock')">
  Unblock
  </button>

  </div>

  `;

 });

}


async function regenerate(id){

 const r=await fetch(
 "/api/developer/regenerate-key",
 {
 method:"POST",
 headers:{
 "Content-Type":"application/json"
 },
 body:JSON.stringify({id})
 });

 alert(await r.text());

 loadKeys();

}


async function toggle(id,action){

 const r=await fetch(
 "/api/developer/key-control",
 {
 method:"POST",
 headers:{
 "Content-Type":"application/json"
 },
 body:JSON.stringify({
 id,
 action
 })
 });

 alert(await r.text());

 loadKeys();

}


loadKeys();

</script>

</body>
</html>
HTML

git add .
git commit -m "Add developer portal UI"
git push

echo "=== Developer Portal Created ==="
