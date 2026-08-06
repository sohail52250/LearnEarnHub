#!/data/data/com.termux/files/usr/bin/bash

echo "Installing Phase 6..."

npm install multer


# Create profile table SQL file

cat > database_phase6.sql <<'SQL'

create table if not exists profiles (
id uuid primary key default gen_random_uuid(),
user_id uuid references users(id),
bio text,
skills text,
city text,
avatar text,
created_at timestamp default now()
);


create table if not exists reviews (
id uuid primary key default gen_random_uuid(),
user_id uuid references users(id),
reviewer text,
rating integer,
comment text,
created_at timestamp default now()
);


create table if not exists referrals (
id uuid primary key default gen_random_uuid(),
user_id uuid references users(id),
referral_code text,
points integer default 0,
created_at timestamp default now()
);

SQL



mkdir -p uploads



cat > routes/profile.js <<'JS'

const router=require("express").Router();

const db=require("../database");


router.post("/create",async(req,res)=>{


const {data,error}=await db
.from("profiles")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data);

});



router.get("/:id",async(req,res)=>{


const {data,error}=await db
.from("profiles")
.select("*")
.eq("user_id",req.params.id);


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;

JS




cat > routes/reviews.js <<'JS'

const router=require("express").Router();

const db=require("../database");


router.post("/add",async(req,res)=>{


const {data,error}=await db
.from("reviews")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data);

});



router.get("/:id",async(req,res)=>{


const {data,error}=await db
.from("reviews")
.select("*")
.eq("user_id",req.params.id);


res.json(data);

});


module.exports=router;

JS




cat > routes/upload.js <<'JS'

const router=require("express").Router();

const multer=require("multer");


const upload=multer({
dest:"uploads/"
});


router.post("/",upload.single("image"),(req,res)=>{


res.json({

message:"Image uploaded",
file:req.file.filename

});


});


module.exports=router;

JS



cat > public/profile.html <<'HTML'

<!DOCTYPE html>

<html>

<head>

<title>User Profile</title>

<link rel="stylesheet" href="style.css">

</head>


<body>


<div class="card">

<h2>User Profile</h2>


<input id="bio"
placeholder="About you">


<input id="skills"
placeholder="Your skills">


<input id="city"
placeholder="City">


<button onclick="save()">
Save Profile
</button>


</div>



<script>


async function save(){


let r=await fetch("/api/profile/create",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

bio:bio.value,
skills:skills.value,
city:city.value

})

});


alert(await r.text());


}


</script>


</body>

</html>

HTML



echo "Phase 6 complete"

