#!/data/data/com.termux/files/usr/bin/bash

echo "Creating Learn & Earn Hub frontend..."

mkdir -p public


cat > public/style.css <<'CSS'
body{
font-family:Arial,sans-serif;
background:#f2f2f2;
margin:0;
}

header{
background:#007bff;
color:white;
padding:15px;
text-align:center;
}

.card{
background:white;
margin:15px;
padding:20px;
border-radius:12px;
box-shadow:0 2px 5px #ccc;
}

input,textarea,button{
width:100%;
padding:12px;
margin:8px 0;
box-sizing:border-box;
}

button{
background:#007bff;
color:white;
border:0;
border-radius:5px;
}

a{
text-decoration:none;
color:#007bff;
}
CSS


cat > public/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Learn & Earn Hub</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<header>
<h1 id="title">Learn & Earn Hub</h1>
<button onclick="urdu()">اردو</button>
<button onclick="english()">English</button>
</header>


<div class="card">

<h2 id="welcome">
Learn skills and grow your income
</h2>

<p id="text">
Learn free skills, advertise services and connect with people.
</p>


<a href="register.html">
<button>Register</button>
</a>


<a href="login.html">
<button>Login</button>
</a>


<a href="market.html">
<button>Marketplace</button>
</a>


</div>


<script>

function urdu(){
document.getElementById("welcome").innerHTML=
"ہنر سیکھیں اور آگے بڑھیں";

document.getElementById("text").innerHTML=
"مفت تعلیم حاصل کریں، اپنی سروس کا اشتہار لگائیں اور لوگوں سے رابطہ کریں";
}


function english(){
location.reload();
}

</script>

</body>
</html>
HTML



cat > public/register.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">
<title>Register</title>
</head>

<body>

<div class="card">

<h2>Register</h2>

<input id="name" placeholder="Name">

<input id="email" placeholder="Email">

<input id="password" type="password" placeholder="Password">

<button onclick="register()">Create Account</button>

</div>


<script>

async function register(){

let r=await fetch("/api/auth/register",
{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({

name:name.value,
email:email.value,
password:password.value

})

});


let d=await r.json();

alert(JSON.stringify(d));

}

</script>

</body>
</html>
HTML



cat > public/login.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">
<title>Login</title>
</head>

<body>

<div class="card">

<h2>Login</h2>

<input id="email" placeholder="Email">

<input id="password" type="password" placeholder="Password">

<button onclick="login()">Login</button>

</div>


<script>

async function login(){

let r=await fetch("/api/auth/login",
{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({

email:email.value,
password:password.value

})

});


let d=await r.json();

alert(JSON.stringify(d));

}

</script>

</body>
</html>
HTML



cat > public/market.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">
<title>Marketplace</title>
</head>

<body>

<div class="card">

<h2>Marketplace</h2>

<div id="ads"></div>

</div>


<script>

async function load(){

let r=await fetch("/api/ads");

let ads=await r.json();

ads.forEach(a=>{

document.getElementById("ads").innerHTML+=`

<div class="card">

<h3>${a.title_en}</h3>

<p>${a.description_en}</p>

<p>${a.city}</p>

<p>${a.phone}</p>

</div>

`;

});

}

load();

</script>

</body>
</html>
HTML



cat > public/dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">
<title>Dashboard</title>
</head>

<body>

<div class="card">

<h2>User Dashboard</h2>

<p>
Manage your profile, ads and points.
</p>

<a href="market.html">
<button>View Marketplace</button>
</a>

</div>

</body>
</html>
HTML


echo "Frontend created successfully!"

