#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating LearnEarnHub Admin Verification Panel ==="

# Create admin page

cat > public/admin-business-verification.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Admin Business Verification</title>

<meta name="viewport" content="width=device-width,initial-scale=1">

<link rel="stylesheet" href="/style.css">

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>

<body>

<div class="card">

<h1>🔐 Admin Business Verification</h1>

<div id="status"></div>

<div id="business-list">
Loading...
</div>

</div>


<script src="/admin-business-verification.js"></script>

</body>
</html>
HTML



# Create admin JS

cat > public/admin-business-verification.js <<'JS'

const adminEmail="YOUR_ADMIN_EMAIL_HERE";


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user || user.email!==adminEmail){

document.body.innerHTML=
"<h2>Access denied</h2>";

throw new Error("Not admin");

}



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



async function loadBusinesses(){


const {data,error}=await client

.from("business_profiles")

.select("*")

.eq("verified",false);



if(error){

document.getElementById("business-list").innerHTML=
error.message;

return;

}



document.getElementById("business-list").innerHTML=

(data||[]).map(b=>`

<div class="card">

<h3>${b.company_name}</h3>

<p>${b.description||""}</p>

<p>${b.category||""}</p>


<button onclick="approve('${b.id}')">

✅ Approve

</button>


</div>

`).join("");

}



async function approve(id){


const {error}=await client

.from("business_profiles")

.update({

verified:true

})

.eq("id",id);



if(error){

alert(error.message);

return;

}


alert("Business verified");

loadBusinesses();


}



document.addEventListener(
"DOMContentLoaded",
loadBusinesses
);

JS


echo "=== Admin panel created ==="

