#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Business Marketplace v3"
echo "======================================"


cat > api/business-marketplace-v3.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const search=req.query.search || "";
const category=req.query.category || "";
const city=req.query.city || "";


let query=db
.from("business_profiles_complete")
.select("*")
.eq("verification_status","verified");


if(search){

query=query.ilike(
"company_name",
"%"+search+"%"
);

}


if(category){

query=query.eq(
"category",
category
);

}


if(city){

query=query.eq(
"city",
city
);

}


const {data,error}=await query;


res.json({

success:!error,

businesses:data || [],

error

});


};
JS



cat > public/business-marketplace-v3.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Business Marketplace</title>

<meta charset="UTF-8">

<style>

.card{

border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:12px;

}

.logo{

width:80px;
height:80px;

}

</style>

</head>


<body>


<h1>
Business Marketplace
</h1>


<input id="search"
placeholder="Search business">


<input id="category"
placeholder="Category">


<input id="city"
placeholder="City">


<button onclick="loadBusinesses()">
Search
</button>


<div id="list">
Loading...
</div>



<script>


async function loadBusinesses(){


let url="/api/business-marketplace-v3?"

+
"search="+search.value

+
"&category="+category.value

+
"&city="+city.value;



let r=await fetch(url);

let d=await r.json();



list.innerHTML=(d.businesses||[])

.map(b=>`

<div class="card">


<img class="logo"
src="${b.logo||''}">


<h2>
${b.company_name}
🏆
</h2>


<p>
${b.category||''}
</p>


<p>
${b.description||''}
</p>


<p>
${b.city||''}
</p>


<a href="/public-business-profile.html?user_id=${b.user_id}">
View Profile
</a>


</div>

`)

.join("");

}


loadBusinesses();


</script>


</body>

</html>
HTML



git add .

git commit -m "Add business marketplace v3 verified listings" || true

git push


echo "======================================"
echo " Business Marketplace v3 Added"
echo "======================================"

