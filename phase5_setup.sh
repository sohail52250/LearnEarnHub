#!/data/data/com.termux/files/usr/bin/bash

echo "Installing Phase 5 features..."

npm install multer


mkdir -p public/admin


cat > public/privacy.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Privacy Policy</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="card">
<h1>Privacy Policy</h1>
<p>
Learn & Earn Hub respects user privacy.
We collect only information needed to provide our services.
</p>
</div>
</body>
</html>
HTML


cat > public/terms.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Terms</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="card">
<h1>Terms & Conditions</h1>
<p>
Users must provide correct information.
Illegal activities are not allowed.
</p>
</div>
</body>
</html>
HTML



cat > public/admin/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Admin Panel</title>
<link rel="stylesheet" href="../style.css">
</head>

<body>

<div class="card">

<h2>Admin Approval Panel</h2>

<div id="ads"></div>

</div>


<script>

async function load(){

let r=await fetch("/api/admin/ads");

let data=await r.json();

data.forEach(a=>{

document.getElementById("ads").innerHTML += `

<div class="card">

<h3>${a.title_en}</h3>

<p>${a.description_en}</p>

<button onclick="approve('${a.id}')">
Approve
</button>

</div>

`;

});

}


async function approve(id){

await fetch("/api/admin/approve/"+id,{
method:"POST"
});

alert("Approved");

location.reload();

}


load();

</script>

</body>
</html>
HTML



cat > routes/admin.js <<'JS'
const router=require("express").Router();
const db=require("../database");


router.get("/ads",async(req,res)=>{

const {data,error}=await db
.from("ads")
.select("*")
.eq("approved",false);


if(error)
return res.status(400).json(error);

res.json(data);

});


router.post("/approve/:id",async(req,res)=>{

const {error}=await db
.from("ads")
.update({
approved:true
})
.eq("id",req.params.id);


if(error)
return res.status(400).json(error);


res.json({
message:"Approved"
});

});


module.exports=router;
JS



cat > routes/search.js <<'JS'
const router=require("express").Router();
const db=require("../database");


router.get("/",async(req,res)=>{

let q=req.query.q || "";


const {data,error}=await db
.from("ads")
.select("*")
.or(
`title_en.ilike.%${q}%,city.ilike.%${q}%`
);


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;
JS


echo "Phase 5 files created"

