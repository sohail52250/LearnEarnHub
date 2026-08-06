#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating Business Dashboard files ==="

cat > public/business-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Business Dashboard - LearnEarnHub</title>

<meta name="viewport" content="width=device-width,initial-scale=1">

<link rel="stylesheet" href="/style.css">

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>

</head>

<body>

<div id="global-header"></div>

<section class="card">

<h1>🏢 Business Dashboard</h1>

<div id="status">
Loading...
</div>


<h2>Company Profile</h2>

<input id="company_name" placeholder="Company Name">

<input id="logo_url" placeholder="Logo URL">

<input id="website" placeholder="Website">

<textarea id="description" placeholder="Company Description"></textarea>

<input id="category" placeholder="Category">


<button onclick="saveProfile()">
Save Profile
</button>


<h2>Your Opportunities</h2>

<div id="opportunities">
Loading...
</div>


</section>


<script src="/business-dashboard.js"></script>

</body>
</html>
HTML



cat > public/business-dashboard.js <<'JS'

const client = supabaseClient;


let user =
JSON.parse(localStorage.getItem("user") || "null");


if(!user){

alert("Please login first");

location.href="/login.html";

}



async function loadProfile(){

const {data,error}=await client

.from("business_profiles")

.select("*")

.eq("owner_id",user.id)

.single();



if(data){

company_name.value=data.company_name || "";

logo_url.value=data.logo_url || "";

website.value=data.website || "";

description.value=data.description || "";

category.value=data.category || "";

status.innerHTML =
data.verified
?
"✅ Verified Business"
:
"⏳ Verification Pending";

}

}



async function saveProfile(){

const payload={

owner_id:user.id,

company_name:company_name.value,

logo_url:logo_url.value,

website:website.value,

description:description.value,

category:category.value

};



const {error}=await client

.from("business_profiles")

.upsert(payload);



if(error){

alert(error.message);

return;

}


alert("Profile saved successfully");

}



async function loadOpportunities(){

const {data,error}=await client

.from("job_opportunities")

.select("*")

.eq("business_id",user.id);



if(error){

opportunities.innerHTML=
"Unable to load opportunities";

return;

}


opportunities.innerHTML=

(data||[]).map(j=>`

<div class="card">

<h3>${j.title}</h3>

<p>${j.description||""}</p>

<p>Status: ${j.status}</p>

</div>

`).join("");

}



loadProfile();

loadOpportunities();

JS



echo "=== Business dashboard created ==="

echo "Files:"
echo "public/business-dashboard.html"
echo "public/business-dashboard.js"

