#!/data/data/com.termux/files/usr/bin/bash

echo "Adding Business Registration Flow..."

cat > public/business-register.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Business Registration - LearnEarnHub</title>

<link rel="stylesheet" href="/style.css">

</head>


<body>

<div id="global-header"></div>


<div class="card">

<h1>🏢 Register Your Business</h1>


<input id="company_name"
placeholder="Company Name">


<input id="email"
placeholder="Business Email">


<input id="phone"
placeholder="Phone Number">


<input id="website"
placeholder="Website">


<input id="category"
placeholder="Business Category">


<textarea id="description"
placeholder="Business Description"></textarea>


<input id="logo_url"
placeholder="Logo URL (optional)">



<button onclick="registerBusiness()">
Create Business Account
</button>


<p id="status"></p>


</div>


<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<script src="/supabase-config.js"></script>

<script src="/business-register.js"></script>


</body>
</html>
HTML



cat > public/business-register.js <<'JS'

async function registerBusiness(){


let session =
await supabaseClient.auth.getSession();


let user=session.data.session?.user;


if(!user){

location.href="/login.html";
return;

}



let payload={

owner_id:user.id,

company_name:
company_name.value,

email:
email.value,

phone:
phone.value,

website:
website.value,

category:
category.value,

description:
description.value,

logo_url:
logo_url.value,

verified:false

};



let {error}=await supabaseClient
.from("business_profiles")
.insert(payload);



status.innerHTML =
error
?
"❌ "+error.message
:
"✅ Business registered successfully";


}


JS



cat > public/post-business-opportunity.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>
Post Business Opportunity
</title>

<link rel="stylesheet" href="/style.css">

</head>


<body>

<div id="global-header"></div>


<div class="card">


<h1>
📢 Post Opportunity
</h1>


<input id="title"
placeholder="Opportunity title">


<textarea id="description"
placeholder="Description">
</textarea>


<input id="contact"
placeholder="Contact details">


<button onclick="postOpportunity()">
Publish Opportunity
</button>


<p id="status"></p>


</div>



<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<script src="/supabase-config.js"></script>

<script src="/post-business-opportunity.js"></script>


</body>
</html>
HTML



cat > public/post-business-opportunity.js <<'JS'

async function postOpportunity(){


let session=
await supabaseClient.auth.getSession();


let user=session.data.session?.user;


if(!user){

location.href="/login.html";
return;

}



let {error}=await supabaseClient
.from("business_opportunities")
.insert({

business_id:user.id,

title:title.value,

description:description.value,

contact:contact.value

});



status.innerHTML =
error
?
"❌ "+error.message
:
"✅ Opportunity published";


}


JS



echo "Business registration and opportunity system added."

