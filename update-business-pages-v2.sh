#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Business Pages v2"
echo "======================================"


echo "1) Creating business dashboard API..."

cat > api/business-dashboard-v2.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const business=await db
.from("business_profiles")
.select("*")
.eq("user_id",user_id)
.single();


const opportunities=await db
.from("business_opportunities")
.select("*")
.eq("user_id",user_id);


const applications=await db
.from("opportunity_applications")
.select("*")
.eq("opportunity_id",
opportunities.data?.[0]?.id);


const products=await db
.from("business_products")
.select("*")
.eq("user_id",user_id);


res.json({

success:true,

business:business.data,

opportunities:opportunities.data || [],

applications:applications.data || [],

products:products.data || []

});


};
JS



echo "2) Creating business dashboard page..."

cat > public/business-dashboard-v2.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Business Dashboard</title>
<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:10px;
}

</style>

</head>


<body>


<h1>
Business Dashboard
</h1>


<div id="dashboard">
Loading...
</div>



<script>

let user_id=localStorage.getItem("user_id");


fetch("/api/business-dashboard-v2?user_id="+user_id)

.then(r=>r.json())

.then(d=>{


let b=d.business||{};


document.getElementById("dashboard").innerHTML=`

<div class="card">

<h2>
${b.company_name||"Business"}
</h2>

<p>
${b.description||""}
</p>

<p>
Verification:
${b.verified?"✅ Verified":"Pending"}
</p>

</div>


<div class="card">

<h3>
Opportunities Posted
</h3>

${d.opportunities.length}

</div>


<div class="card">

<h3>
Applications Received
</h3>

${d.applications.length}

</div>


<div class="card">

<h3>
Products / Services
</h3>

${d.products.length}

</div>


`;

});


</script>

</body>

</html>
HTML



echo "3) Creating business profile editor..."

cat > public/business-profile-edit.html <<'HTML'
<!DOCTYPE html>
<html>

<head>
<title>Business Profile</title>
</head>

<body>


<h1>
Create Business Profile
</h1>


<form id="form">


<input id="company_name"
placeholder="Company Name">


<textarea id="description"
placeholder="Business Description"></textarea>


<input id="category"
placeholder="Category">


<input id="city"
placeholder="City">


<input id="contact"
placeholder="Contact">


<button>
Save
</button>


</form>



<script>


form.onsubmit=async(e)=>{

e.preventDefault();


let data={

user_id:localStorage.getItem("user_id"),

company_name:company_name.value,

description:description.value,

category:category.value,

city:city.value,

contact:contact.value

};


let r=await fetch("/api/business-profile",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify(data)

});


alert("Business profile saved");


};


</script>


</body>
</html>
HTML



echo "4) Save changes"

git add .

git commit -m "Update business pages v2 dashboard and profile" || true

git push


echo "======================================"
echo " Business Pages v2 Added"
echo "======================================"

