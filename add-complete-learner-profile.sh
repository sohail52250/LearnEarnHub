#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Learner Profile System"
echo "======================================"

mkdir -p api public database


echo "1) Creating profile schema..."

cat > database/learner-profile.sql <<'SQL'

CREATE TABLE IF NOT EXISTS learner_profiles(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid UNIQUE,
bio text,
skills text,
education text,
experience text,
city text,
country text,
level integer DEFAULT 1,
created_at timestamp DEFAULT now(),
updated_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS learner_badges(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
badge_name text,
description text,
created_at timestamp DEFAULT now()
);


SQL


echo "2) Creating learner profile API..."

cat > api/learner-profile.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const user_id=req.query.user_id;


const profile=await db
.from("learner_profiles")
.select("*")
.eq("user_id",user_id)
.single();


const badges=await db
.from("learner_badges")
.select("*")
.eq("user_id",user_id);


const progress=await db
.from("lesson_progress")
.select("*")
.eq("user_id",user_id);


res.json({
success:true,
profile:profile.data,
badges:badges.data,
completed_lessons:progress.data?.length || 0
});

}



if(req.method==="POST"){

const {
user_id,
bio,
skills,
education,
experience,
city,
country
}=req.body;


const {data,error}=await db
.from("learner_profiles")
.upsert([{
user_id,
bio,
skills,
education,
experience,
city,
country
}])
.select();


res.json({
success:!error,
data,
error
});

}


res.status(405).json({
error:"Method not allowed"
});

};
JS


echo "3) Creating learner profile page..."

cat > public/learner-profile.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Learner Profile</title>
<meta charset="UTF-8">
</head>

<body>

<h1>Learner Profile / طالب پروفائل</h1>

<div id="profile">
Loading profile...
</div>


<script>

const user_id=localStorage.getItem("user_id");


fetch("/api/learner-profile?user_id="+user_id)
.then(r=>r.json())
.then(data=>{

document.getElementById("profile").innerHTML=`

<h2>${data.profile?.bio || "No Bio"}</h2>

<p>Skills:
${data.profile?.skills || "Not added"}
</p>

<p>
Level:
${data.profile?.level || 1}
</p>

<p>
Completed Lessons:
${data.completed_lessons}
</p>

<h3>Badges</h3>

${(data.badges||[])
.map(b=>"<p>🏅 "+b.badge_name+"</p>")
.join("")}

`;

});

</script>


</body>
</html>
HTML


echo "4) Save changes..."

git add .

git commit -m "Add complete learner profile system" || true

git push


echo "======================================"
echo " Learner Profile Added"
echo "======================================"

