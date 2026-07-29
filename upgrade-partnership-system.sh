#!/data/data/com.termux/files/usr/bin/bash

echo "Upgrading LearnEarnHub Partnership System..."

mkdir -p public/admin

cat > public/admin-partnerships.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Partnership Admin - LearnEarnHub</title>
<link rel="stylesheet" href="/style.css">
</head>

<body>

<div id="global-header"></div>

<div class="card">
<h1>🤝 Partnership Requests</h1>

<div id="requests">
Loading requests...
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

<script>

async function loadRequests(){

let {data,error}=await supabaseClient
.from("partnership_requests")
.select("*")
.order("created_at",{ascending:false});

if(error){
requests.innerHTML=error.message;
return;
}

requests.innerHTML=data.map(r=>`

<div class="card">

<h3>${r.name}</h3>
<p>${r.email}</p>
<p>${r.details}</p>
<p>Status: ${r.status}</p>

</div>

`).join("");

}

loadRequests();

</script>

</body>
</html>
HTML

echo "Professional partnership admin page created."

