#!/data/data/com.termux/files/usr/bin/bash

echo "Creating secure partnership admin system..."

# Admin login page

cat > public/admin-login.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Admin Login - LearnEarnHub</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="/style.css">
</head>

<body>

<div class="card">

<h1>🔐 Admin Login</h1>

<input id="email" placeholder="Admin Email">
<br><br>

<input id="password" type="password" placeholder="Password">
<br><br>

<button onclick="login()">Login</button>

<p id="status"></p>

</div>


<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

<script>

async function login(){

let email=document.getElementById("email").value;
let password=document.getElementById("password").value;

let {data,error}=await supabaseClient.auth.signInWithPassword({
email,
password
});

if(error){

status.innerHTML="❌ "+error.message;
return;

}

location.href="/admin-partnerships.html";

}

</script>

</body>
</html>
HTML


# Protected dashboard JS

cat > public/admin-partnerships.js <<'JS'

async function checkAdmin(){

let {data}=await supabaseClient.auth.getSession();

if(!data.session){

location.href="/admin-login.html";
return;

}

loadRequests();

}


async function loadRequests(){

let box=document.getElementById("requests");

let {data,error}=await supabaseClient
.from("partnership_requests")
.select("*")
.order("created_at",{ascending:false});


if(error){

box.innerHTML=error.message;
return;

}


box.innerHTML=data.map(r=>`

<div class="card">

<h3>${r.name}</h3>

<p>Email: ${r.email}</p>

<p>${r.details}</p>

<p>Status: ${r.status || "pending"}</p>

<button onclick="updateStatus('${r.id}','approved')">
Approve
</button>

<button onclick="updateStatus('${r.id}','rejected')">
Reject
</button>


</div>

`).join("");

}



async function updateStatus(id,status){

await supabaseClient
.from("partnership_requests")
.update({
status:status,
reviewed_at:new Date()
})
.eq("id",id);


loadRequests();

}



async function logout(){

await supabaseClient.auth.signOut();

location.href="/admin-login.html";

}


checkAdmin();

JS


# Update dashboard

python - <<'PY'
p="public/admin-partnerships.html"

s=open(p).read()

if "admin-partnerships.js" not in s:
    s=s.replace("</body>",
    '<button onclick="logout()">Logout</button>\n<script src="/admin-partnerships.js"></script>\n</body>')

open(p,"w").write(s)

PY


echo "Secure admin system created."

