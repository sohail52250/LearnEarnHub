#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Supabase Auth Setup ==="

mkdir -p public/js


cat > public/js/supabase-config.js <<'JS'
window.SUPABASE_URL="YOUR_SUPABASE_URL";
window.SUPABASE_ANON_KEY="YOUR_SUPABASE_ANON_KEY";

window.supabaseClient = supabase.createClient(
 window.SUPABASE_URL,
 window.SUPABASE_ANON_KEY
);
JS



cat > public/login.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Login</title>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/js/supabase-config.js"></script>
</head>

<body>

<h2>Login</h2>

<input id="email" placeholder="Email">
<br><br>

<input id="password" type="password" placeholder="Password">
<br><br>

<button onclick="login()">Login</button>

<button onclick="register()">Register</button>


<script>

async function register(){

const {error}=await supabaseClient.auth.signUp({

email:email.value,
password:password.value

});

alert(
error ? error.message : "Registration successful"
);

}



async function login(){

const {error}=await supabaseClient.auth.signInWithPassword({

email:email.value,
password:password.value

});


if(error){

alert(error.message);

}else{

location.href="/dashboard.html";

}

}


</script>


</body>
</html>
HTML



cat > public/js/dashboard-auth.js <<'JS'

async function loadUser(){

const {data}=await supabaseClient.auth.getUser();


if(!data.user){

location.href="/login.html";

return;

}


document.getElementById("user-email").innerHTML =
data.user.email;


}

loadUser();

JS



echo "✅ Login page created"
echo "✅ Register system created"
echo "✅ Real user check created"

echo ""
echo "IMPORTANT:"
echo "Replace YOUR_SUPABASE_URL"
echo "Replace YOUR_SUPABASE_ANON_KEY"
echo "inside public/js/supabase-config.js"

