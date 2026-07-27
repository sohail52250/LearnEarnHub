#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub CV Profile Upgrade"
echo "======================================"


cat > database/cv-profile.sql <<'SQL'

CREATE TABLE IF NOT EXISTS learner_cv_profiles(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid UNIQUE,

full_name text,
headline text,
profile_photo text,

phone text,
email text,

city text,
country text,

bio text,

education text,
experience text,

technical_skills text,
soft_skills text,

projects text,

certifications text,

languages text,

career_goal text,

availability text,

linkedin text,
github text,
portfolio text,

created_at timestamp DEFAULT now(),
updated_at timestamp DEFAULT now()

);


SQL


cat > api/cv-profile.js <<'JS'

const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){

const user_id=req.query.user_id;


const {data,error}=await db
.from("learner_cv_profiles")
.select("*")
.eq("user_id",user_id)
.single();


return res.json({
success:!error,
profile:data,
error
});

}



if(req.method==="POST"){


const profile=req.body;


const {data,error}=await db
.from("learner_cv_profiles")
.upsert([profile])
.select();


return res.json({
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



cat > public/learner-cv.html <<'HTML'

<!DOCTYPE html>
<html>

<head>
<title>Learner CV Profile</title>
<meta charset="UTF-8">
</head>


<body>

<h1>Professional Learner CV</h1>


<div id="cv">
Loading CV...
</div>


<script>

let user_id=localStorage.getItem("user_id");


fetch("/api/cv-profile?user_id="+user_id)
.then(r=>r.json())
.then(d=>{


let p=d.profile||{};


document.getElementById("cv").innerHTML=`

<h2>${p.full_name||""}</h2>

<h3>${p.headline||""}</h3>

<p>${p.bio||""}</p>

<hr>

<h3>Contact</h3>
${p.email||""}<br>
${p.phone||""}<br>
${p.city||""}, ${p.country||""}


<h3>Education</h3>
${p.education||""}


<h3>Experience</h3>
${p.experience||""}


<h3>Skills</h3>
${p.technical_skills||""}
<br>
${p.soft_skills||""}


<h3>Projects</h3>
${p.projects||""}


<h3>Certificates</h3>
${p.certifications||""}


<h3>Languages</h3>
${p.languages||""}


<h3>Career Goal</h3>
${p.career_goal||""}


`;

});

</script>


</body>
</html>

HTML



git add .

git commit -m "Add complete CV style learner profile"

git push


echo "CV PROFILE SYSTEM ADDED"

