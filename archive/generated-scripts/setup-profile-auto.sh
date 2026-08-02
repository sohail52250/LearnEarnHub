#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Profile System Setup ==="


mkdir -p services api public



cat > database/profile-system.sql <<'SQL'

CREATE TABLE IF NOT EXISTS profiles (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

full_name TEXT,

avatar_url TEXT,

bio TEXT,

created_at TIMESTAMP DEFAULT NOW(),

updated_at TIMESTAMP DEFAULT NOW()

);


CREATE INDEX IF NOT EXISTS profiles_user_idx
ON profiles(user_id);

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
.from("profiles")
.select("*")
.eq("user_id",user_id)
.single();



if(error && error.code!=="PGRST116")
throw error;


return data || {};

}



async function updateProfile(profile){


const {data,error}=await db
.from("profiles")
.upsert({

user_id:profile.user_id,

full_name:profile.full_name,

avatar_url:profile.avatar_url,

bio:profile.bio,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return data;

}



module.exports={
getProfile,
updateProfile
};

JS



cat > api/profile.js <<'JS'
const service=require("../services/profile-service");


module.exports=async function(req,res){

try{


if(req.method==="GET"){

return res.json(
await service.getProfile(
req.query.user_id
)
);

}



if(req.method==="POST"){

return res.json(
await service.updateProfile(
req.body
)
);

}



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


// Profile API

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



cat > public/profile.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Profile</title>

<style>

body{
font-family:Arial;
background:#f5f7fb;
padding:20px;
}

.box{

background:white;
max-width:500px;
margin:auto;
padding:20px;
border-radius:12px;

}

input,textarea,button{

width:100%;
padding:12px;
margin:8px 0;

}

button{

background:#1565c0;
color:white;
border:0;

}

</style>

</head>


<body>


<div class="box">

<h2>👤 My Profile</h2>


<input id="name" placeholder="Full Name">


<input id="avatar" placeholder="Photo URL">


<textarea id="bio" placeholder="About me"></textarea>


<button onclick="save()">
Save Profile
</button>


<p id="msg"></p>


</div>



<script>


const user_id=
new URLSearchParams(location.search)
.get("user_id");



async function save(){


let res=await fetch("/api/profile",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

user_id,

full_name:name.value,

avatar_url:avatar.value,

bio:bio.value

})

});


let data=await res.json();


msg.innerText=
"Profile saved ✅";

}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Profile system created"

echo ""
echo "SQL file:"
echo "database/profile-system.sql"

echo ""
echo "Page:"
echo "/profile.html?user_id=USER_ID"


