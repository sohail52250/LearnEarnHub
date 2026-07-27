#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Consolidation V1"
echo "======================================"

mkdir -p database

cat > database/unified-wallet.sql <<'SQL'
CREATE TABLE IF NOT EXISTS unified_wallets (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid UNIQUE,
    points integer DEFAULT 0,
    earnings numeric DEFAULT 0,
    rewards numeric DEFAULT 0,
    last_updated timestamp DEFAULT now()
);

CREATE TABLE IF NOT EXISTS wallet_transactions (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid,
    transaction_type text,
    amount numeric DEFAULT 0,
    points integer DEFAULT 0,
    description text,
    created_at timestamp DEFAULT now()
);
SQL

cat > database/unified-profile.sql <<'SQL'
CREATE TABLE IF NOT EXISTS unified_profiles (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid UNIQUE,
    full_name text,
    headline text,
    bio text,
    skills text,
    education text,
    experience text,
    certifications text,
    profile_type text DEFAULT 'learner',
    city text,
    country text,
    updated_at timestamp DEFAULT now()
);
SQL

cat > api/unified-profile.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){
const user_id=req.query.user_id;

const {data,error}=await db
.from("unified_profiles")
.select("*")
.eq("user_id",user_id)
.single();

return res.json({success:true,data,error});
}

if(req.method==="POST"){

const body=req.body;

const {data,error}=await db
.from("unified_profiles")
.upsert([body])
.select();

return res.json({
success:!error,
data,
error
});
}

res.status(405).json({error:"Method not allowed"});
};
JS

cat > public/unified-profile.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Unified Profile</title>
</head>
<body>

<h1>Unified Profile</h1>

<form id="profileForm">

<input id="full_name" placeholder="Full Name"><br><br>

<input id="headline" placeholder="Professional Headline"><br><br>

<textarea id="bio" placeholder="Bio"></textarea><br><br>

<input id="skills" placeholder="Skills"><br><br>

<input id="city" placeholder="City"><br><br>

<input id="country" placeholder="Country"><br><br>

<button>Save Profile</button>

</form>

<script>

profileForm.onsubmit=async(e)=>{

e.preventDefault();

await fetch("/api/unified-profile",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

user_id:localStorage.getItem("user_id"),

full_name:full_name.value,

headline:headline.value,

bio:bio.value,

skills:skills.value,

city:city.value,

country:country.value

})

});

alert("Profile saved");

};

</script>

</body>
</html>
HTML

git add .
git commit -m "Add unified wallet and unified profile foundation" || true
git push

echo "======================================"
echo " Consolidation V1 Completed"
echo "======================================"

