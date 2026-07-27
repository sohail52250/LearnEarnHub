#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Public Business Profile"
echo "======================================"


cat > api/public-business-profile.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const profile=await db
.from("business_profiles_complete")
.select("*")
.eq("user_id",user_id)
.single();


const opportunities=await db
.from("business_opportunities")
.select("*")
.eq("user_id",user_id);


const reviews=await db
.from("business_reviews")
.select("*")
.eq("business_id",user_id);


res.json({

success:true,

profile:profile.data,

opportunities:opportunities.data || [],

reviews:reviews.data || []

});


};
JS



cat > public/public-business-profile.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Business Profile</title>

<meta charset="UTF-8">

<style>

body{
font-family:Arial;
padding:20px;
}

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:10px;
}

.logo{
width:120px;
height:120px;
object-fit:cover;
}

</style>

</head>


<body>


<h1>
Business Profile
</h1>


<div id="profile">
Loading...
</div>



<script>


let id=new URLSearchParams(location.search)
.get("user_id");


fetch("/api/public-business-profile?user_id="+id)

.then(r=>r.json())

.then(d=>{


let p=d.profile||{};


document.getElementById("profile").innerHTML=`

<div class="card">


<img class="logo"
src="${p.logo||''}">


<h2>
${p.company_name||''}
</h2>


<h3>
${p.category||''}
</h3>


<p>
${p.verification_status=="verified"?
"✅ Verified Business":
"⏳ Verification Pending"}
</p>


<p>
${p.description||''}
</p>


</div>



<div class="card">

<h3>
About Company
</h3>

<p>
${p.about_company||''}
</p>

</div>



<div class="card">

<h3>
Services
</h3>

<p>
${p.services||''}
</p>

</div>



<div class="card">

<h3>
Products
</h3>

<p>
${p.products||''}
</p>

</div>



<div class="card">

<h3>
Portfolio
</h3>

<p>
${p.portfolio||''}
</p>

</div>



<div class="card">

<h3>
Contact
</h3>

${p.phone||''}<br>
${p.email||''}<br>
${p.website||''}

</div>



<div class="card">

<h3>
Opportunities
</h3>

${
(d.opportunities||[])
.map(o=>
`
<p>
${o.title||o.title_en||"Opportunity"}
</p>
`
)
.join("")
}


</div>


`;

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add public business profile page" || true

git push


echo "======================================"
echo " Public Business Profile Added"
echo "======================================"

