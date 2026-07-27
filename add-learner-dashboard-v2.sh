#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Learner Dashboard v2"
echo "======================================"


cat > api/learner-dashboard-v2.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const user=await db
.from("users")
.select("id,name,email,points,language,phone")
.eq("id",user_id)
.single();


const profile=await db
.from("learner_cv_profiles")
.select("*")
.eq("user_id",user_id)
.single();


const courses=await db
.from("lesson_progress")
.select("*")
.eq("user_id",user_id);


const badges=await db
.from("learner_badges")
.select("*")
.eq("user_id",user_id);



let completion=0;

if(profile.data){

let fields=[
"full_name",
"headline",
"bio",
"education",
"experience",
"technical_skills",
"projects",
"certifications"
];

let done=fields.filter(
f=>profile.data[f]
).length;


completion=Math.round(
(done/fields.length)*100
);

}



res.json({

success:true,

user:user.data,

profile:profile.data,

profile_completion:completion,

completed_courses:courses.data?.length || 0,

badges:badges.data || []

});


};
JS



cat > public/learner-dashboard-v2.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Learner Dashboard v2</title>

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

</style>

</head>


<body>


<h1>
Learner Dashboard
</h1>


<div id="dashboard">
Loading...
</div>


<script>


const user_id=localStorage.getItem("user_id");


fetch("/api/learner-dashboard-v2?user_id="+user_id)

.then(r=>r.json())

.then(d=>{


let u=d.user||{};
let p=d.profile||{};


document.getElementById("dashboard").innerHTML=`

<div class="card">

<h2>
${u.name||"Learner"}
</h2>

<p>
Points: ⭐ ${u.points||0}
</p>

<p>
Profile Complete:
${d.profile_completion}%
</p>

</div>



<div class="card">

<h3>CV Profile</h3>

<a href="/public-learner-cv.html?user_id=${user_id}">
View Public CV
</a>

</div>



<div class="card">

<h3>Learning Progress</h3>

<p>
Completed Lessons:
${d.completed_courses}
</p>

</div>



<div class="card">

<h3>Skills</h3>

<p>
${p.technical_skills||"Add your skills"}
</p>

</div>



<div class="card">

<h3>Badges</h3>

${
(d.badges||[])
.map(
b=>"🏅 "+b.badge_name
)
.join("<br>")
}


</div>


`;

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add learner dashboard v2 system" || true

git push


echo "======================================"
echo " Learner Dashboard v2 Added"
echo "======================================"

