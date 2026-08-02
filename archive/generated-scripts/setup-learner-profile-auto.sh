#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Learner Profile System Setup ==="

mkdir -p services api public/profile



cat > database/learner-profile.sql <<'SQL'

CREATE TABLE IF NOT EXISTS learner_profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

full_name TEXT,

bio TEXT,

profile_image TEXT,

portfolio_url TEXT,

location TEXT,

created_at TIMESTAMP DEFAULT NOW(),

updated_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS learner_reviews (

id BIGSERIAL PRIMARY KEY,

learner_id UUID NOT NULL,

reviewer_id UUID,

rating INTEGER CHECK(rating >=1 AND rating <=5),

comment TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS learner_profile_user_idx

ON learner_profiles(user_id);


SQL



cat > services/profile-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getProfile(user_id){


const {data,error}=await db
.from("learner_profiles")
.select("*")
.eq("user_id",user_id)
.single();


if(error && error.code!=="PGRST116")
throw error;


return data || null;

}



async function updateProfile(data){


const {data:result,error}=await db
.from("learner_profiles")
.upsert({

...data,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return result;

}



async function addReview(data){


const {data:result,error}=await db
.from("learner_reviews")
.insert(data)
.select()
.single();


if(error) throw error;


return result;

}



module.exports={

getProfile,

updateProfile,

addReview

};

JS



cat > api/profile.js <<'JS'
const service=require("../services/profile-service");


module.exports=async function(req,res){

try{


if(req.query.user_id){

return res.json(
await service.getProfile(
req.query.user_id
)
);

}



if(req.body.action==="update"){

return res.json(
await service.updateProfile(
req.body.data
)
);

}



if(req.body.action==="review"){

return res.json(
await service.addReview(
req.body.data
)
);

}



res.status(400).json({
error:"Invalid request"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/profile" server.js
then

cat >> server.js <<'JS'


// Learner Profile API

const profile=require("./api/profile");


app.get(
"/api/profile",
profile
);


app.post(
"/api/profile",
profile
);


JS

fi



cat > public/profile/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Learner Portfolio</title>

<style>

body{

font-family:Arial;

background:#f5f7fb;

padding:20px;

}

.card{

background:white;

padding:20px;

border-radius:12px;

}

input,textarea,button{

width:100%;

padding:10px;

margin:5px;

}

button{

background:#1565c0;

color:white;

border:0;

}

</style>

</head>


<body>


<div class="card">


<h1>🎓 Learner Portfolio</h1>


<input id="user_id" placeholder="User ID">


<input id="full_name" placeholder="Full Name">


<textarea id="bio" placeholder="About your skills"></textarea>


<input id="portfolio_url" placeholder="Portfolio URL">


<button onclick="save()">

Save Profile

</button>


<p id="msg"></p>


</div>



<script>


async function save(){


let r=await fetch(
"/api/profile",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"update",

data:{

user_id:user_id.value,

full_name:full_name.value,

bio:bio.value,

portfolio_url:portfolio_url.value

}

})

});


let d=await r.json();


msg.innerText=
d.error || "Profile saved ✅";


}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Learner Profile Portfolio created"

echo ""
echo "Features:"
echo "Profile"
echo "Bio"
echo "Portfolio"
echo "Reviews foundation"
echo "Ready for employer viewing"


