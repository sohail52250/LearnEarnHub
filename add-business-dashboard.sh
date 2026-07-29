#!/data/data/com.termux/files/usr/bin/bash

echo "Creating Business Dashboard..."

cat > public/business-dashboard.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Business Dashboard - LearnEarnHub</title>

<link rel="stylesheet" href="/style.css">

<link rel="stylesheet" href="/components/leh-design-system.css">

</head>

<body>

<div id="global-header"></div>


<div class="card">

<h1>🏢 Business Dashboard</h1>

<div id="business-info">
Loading...
</div>


<h2>Edit Profile</h2>


<input id="company_name" placeholder="Company Name">

<input id="email" placeholder="Email">

<input id="phone" placeholder="Phone">

<input id="website" placeholder="Website">


<textarea id="description"
placeholder="Company Description"></textarea>


<input id="logo_url"
placeholder="Logo URL">


<button onclick="saveBusiness()">
Save Profile
</button>


<h2>📌 My Opportunities</h2>

<div id="opportunities">
Loading...
</div>


</div>


<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<script src="/supabase-config.js"></script>

<script src="/business-dashboard.js"></script>


</body>
</html>
HTML



cat > public/business-dashboard.js <<'JS'

let user=null;


async function loadBusiness(){

const session =
await supabaseClient.auth.getSession();


user=session.data.session?.user;


if(!user){

location.href="/login.html";
return;

}


let {data}=await supabaseClient
.from("business_profiles")
.select("*")
.eq("owner_id",user.id)
.single();



if(data){

company_name.value=data.company_name || "";
email.value=data.email || "";
phone.value=data.phone || "";
website.value=data.website || "";
description.value=data.description || "";
logo_url.value=data.logo_url || "";


business-info.innerHTML=
`
<h3>${data.company_name}</h3>
<p>
${data.verified ? "✅ Verified Business" : "⏳ Pending Verification"}
</p>
`;

}


loadOpportunities();


}



async function saveBusiness(){


let payload={

owner_id:user.id,

company_name:company_name.value,

email:email.value,

phone:phone.value,

website:website.value,

description:description.value,

logo_url:logo_url.value

};


let {error}=await supabaseClient
.from("business_profiles")
.upsert(payload,
{onConflict:"owner_id"});


alert(
error ? error.message :
"Profile saved successfully"
);


}



async function loadOpportunities(){

let {data}=await supabaseClient
.from("business_opportunities")
.select("*")
.eq("business_id",user.id);


opportunities.innerHTML =
(data||[])
.map(o=>`

<div class="card">

<h3>${o.title}</h3>

<p>${o.description}</p>

</div>

`).join("")
||"No opportunities yet";


}


loadBusiness();

JS


echo "Business dashboard created."

