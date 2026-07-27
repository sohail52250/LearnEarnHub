#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub CV Public Export System"
echo "======================================"


cat > public/public-learner-cv.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Public Learner CV</title>
<meta charset="UTF-8">

<style>
body{
font-family:Arial;
padding:20px;
}

.cv-box{
border:1px solid #ddd;
padding:20px;
}

button{
padding:10px;
}
</style>

</head>

<body>


<h1>LearnEarnHub Learner CV</h1>

<button onclick="window.print()">
Download / Print CV
</button>


<div class="cv-box" id="cv">
Loading...
</div>



<script>

const params=new URLSearchParams(location.search);

const user_id=params.get("user_id");


fetch("/api/cv-profile?user_id="+user_id)

.then(r=>r.json())

.then(d=>{


let p=d.profile || {};


document.getElementById("cv").innerHTML=`

<h2>${p.full_name||""}</h2>

<h3>${p.headline||""}</h3>


<p>
${p.bio||""}
</p>


<h3>Education</h3>
<p>${p.education||""}</p>


<h3>Experience</h3>
<p>${p.experience||""}</p>


<h3>Technical Skills</h3>
<p>${p.technical_skills||""}</p>


<h3>Soft Skills</h3>
<p>${p.soft_skills||""}</p>


<h3>Projects</h3>
<p>${p.projects||""}</p>


<h3>Certificates</h3>
<p>${p.certifications||""}</p>


<h3>Languages</h3>
<p>${p.languages||""}</p>


<h3>Contact</h3>
<p>
${p.email||""}<br>
${p.phone||""}
</p>


`;

});


</script>


</body>
</html>
HTML



cat > api/profile-completion.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const {data}=await db
.from("learner_cv_profiles")
.select("*")
.eq("user_id",user_id)
.single();


if(!data)
return res.json({
percentage:0
});


let fields=[
"full_name",
"headline",
"bio",
"education",
"experience",
"technical_skills",
"soft_skills",
"projects",
"certifications",
"languages"
];


let completed=fields.filter(
x=>data[x]
).length;


let percentage=Math.round(
(completed/fields.length)*100
);


res.json({
percentage,
completed,
total:fields.length
});


};
JS



git add .

git commit -m "Add public learner CV and completion system" || true

git push


echo "======================================"
echo " CV Public Export Added"
echo "======================================"

