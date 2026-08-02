#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating Supabase Developer Login ==="

cat > public/developer/login.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Developer Portal</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<style>
body{font-family:Arial;padding:30px}
.card{max-width:400px;margin:auto;padding:20px;border:1px solid #ddd;border-radius:10px}
input,button{width:100%;padding:12px;margin:8px 0}
</style>
</head>

<body>

<div class="card">

<h2>Developer Portal</h2>

<input id="email" placeholder="Email">

<input id="password" type="password" placeholder="Password">

<button onclick="login()">Login</button>

<p id="msg"></p>

</div>

<script>

const supabaseClient=supabase.createClient(
"https://srarnaqyoiqotdntzsyc.supabase.co",
"YOUR_SUPABASE_ANON_KEY"
);


async function login(){

let email=document.getElementById("email").value;
let password=document.getElementById("password").value;

let {data,error}=await supabaseClient.auth.signInWithPassword({
email,
password
});


if(error){
document.getElementById("msg").innerText=error.message;
return;
}


localStorage.setItem(
"dev_token",
data.session.access_token
);


location.href="/developer/dashboard.html";

}

</script>

</body>
</html>
HTML


python - <<'PY'
from pathlib import Path
p=Path("public/developer/dashboard.html")
s=p.read_text()

s=s.replace(
'"Authorization":"Bearer "+localStorage.getItem("dev_token")',
'"Authorization":"Bearer "+localStorage.getItem("dev_token")'
)

p.write_text(s)
print("Dashboard checked")
PY


git add .
git commit -m "Connect developer portal with Supabase login"
git push

vercel --prod

echo "=== Done ==="
