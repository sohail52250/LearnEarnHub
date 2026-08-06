#!/data/data/com.termux/files/usr/bin/bash

echo "Adding Learn & Earn features..."

mkdir -p public


cat > public/post-ad.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Post Advertisement</title>
<link rel="stylesheet" href="style.css">
<meta name="viewport" content="width=device-width,initial-scale=1">
</head>

<body>

<div class="card">

<h2>
Post Your Service / Advertisement
</h2>

<input id="title_en" placeholder="Title English">

<input id="title_ur" placeholder="عنوان اردو">

<textarea id="description_en" placeholder="Description English"></textarea>

<textarea id="description_ur" placeholder="تفصیل اردو"></textarea>

<input id="phone" placeholder="Phone / WhatsApp">

<input id="city" placeholder="City">

<input id="category" placeholder="Category">

<button onclick="postAd()">
Publish Ad
</button>

</div>


<script>

async function postAd(){

let response=await fetch("/api/ads/create",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

title_en:title_en.value,
title_ur:title_ur.value,

description_en:description_en.value,
description_ur:description_ur.value,

phone:phone.value,
city:city.value,
category:category.value,

approved:false

})

});


let data=await response.json();

alert(JSON.stringify(data));

}

</script>

</body>
</html>
HTML



cat > public/learn.html <<'HTML'
<!DOCTYPE html>
<html>

<head>
<title>Learn Skills</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<div class="card">

<h2>
Learn Skills / ہنر سیکھیں
</h2>


<ul>

<li>
Freelancing Basics
</li>

<li>
Digital Marketing
</li>

<li>
Graphic Design
</li>

<li>
Programming
</li>

<li>
AI Tools
</li>

</ul>


</div>


</body>

</html>
HTML



cat > public/add-course.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Add Course</title>
<link rel="stylesheet" href="style.css">
</head>


<body>

<div class="card">

<h2>Add Learning Content</h2>


<input id="title_en"
placeholder="Course title English">


<input id="title_ur"
placeholder="Course title Urdu">


<textarea id="content_en"
placeholder="English content">
</textarea>


<textarea id="content_ur"
placeholder="Urdu content">
</textarea>


<button onclick="save()">
Save Course
</button>


</div>



<script>

async function save(){

let r=await fetch("/api/courses/create",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

title_en:title_en.value,
title_ur:title_ur.value,

content_en:content_en.value,
content_ur:content_ur.value

})

});


alert(await r.text());

}

</script>


</body>
</html>
HTML



echo "Creating course API..."

cat > routes/courses.js <<'JS'
const router=require("express").Router();
const db=require("../database");


router.post("/create",async(req,res)=>{

const {data,error}=await db
.from("courses")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data);

});


router.get("/",async(req,res)=>{

const {data,error}=await db
.from("courses")
.select("*");


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;
JS


echo "Done!"

