#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub CV Builder"
echo "======================================"


cat > public/edit-learner-cv.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Edit Learner CV</title>
<meta charset="UTF-8">
<style>
body{font-family:Arial;padding:20px}
input,textarea{width:100%;padding:10px;margin:6px 0}
button{padding:12px;background:#222;color:white}
</style>
</head>

<body>

<h1>Build Your Professional CV</h1>

<form id="cvForm">

<input id="full_name" placeholder="Full Name">

<input id="headline" placeholder="Professional Headline">

<input id="email" placeholder="Email">

<input id="phone" placeholder="Phone">

<input id="city" placeholder="City">

<input id="country" placeholder="Country">

<textarea id="bio" placeholder="About Me"></textarea>

<textarea id="education" placeholder="Education"></textarea>

<textarea id="experience" placeholder="Work Experience"></textarea>

<textarea id="technical_skills" placeholder="Technical Skills"></textarea>

<textarea id="soft_skills" placeholder="Soft Skills"></textarea>

<textarea id="projects" placeholder="Projects / Portfolio"></textarea>

<textarea id="certifications" placeholder="Certificates"></textarea>

<textarea id="languages" placeholder="Languages"></textarea>

<textarea id="career_goal" placeholder="Career Goal"></textarea>

<input id="linkedin" placeholder="LinkedIn">

<input id="github" placeholder="GitHub">

<input id="portfolio" placeholder="Portfolio Website">


<button>
Save CV
</button>


</form>


<script>

const user_id=localStorage.getItem("user_id");


document
.getElementById("cvForm")
.addEventListener("submit",async(e)=>{

e.preventDefault();


let data={

user_id,

full_name:full_name.value,
headline:headline.value,
email:email.value,
phone:phone.value,

city:city.value,
country:country.value,

bio:bio.value,

education:education.value,
experience:experience.value,

technical_skills:technical_skills.value,
soft_skills:soft_skills.value,

projects:projects.value,

certifications:certifications.value,

languages:languages.value,

career_goal:career_goal.value,

linkedin:linkedin.value,
github:github.value,
portfolio:portfolio.value

};


let r=await fetch("/api/cv-profile",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify(data)

});


let result=await r.json();

alert(
result.success?
"CV Saved Successfully":
"Error Saving CV"
);


});

</script>


</body>
</html>
HTML



cat > public/view-learner-cv.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Learner CV</title>
</head>

<body>

<h1>Professional CV</h1>

<div id="cv">
Loading...
</div>


<script>

let user_id=localStorage.getItem("user_id");


fetch("/api/cv-profile?user_id="+user_id)

.then(r=>r.json())

.then(d=>{

let p=d.profile;


document.getElementById("cv").innerHTML=`

<h2>${p.full_name||""}</h2>

<h3>${p.headline||""}</h3>

<p>${p.bio||""}</p>

<h3>Education</h3>
<p>${p.education||""}</p>


<h3>Experience</h3>
<p>${p.experience||""}</p>


<h3>Skills</h3>
<p>${p.technical_skills||""}</p>

<p>${p.soft_skills||""}</p>


<h3>Projects</h3>
<p>${p.projects||""}</p>


<h3>Certificates</h3>
<p>${p.certifications||""}</p>


<h3>Languages</h3>
<p>${p.languages||""}</p>


<h3>Contact</h3>
${p.email||""}<br>
${p.phone||""}


`;

});

</script>

</body>
</html>
HTML



git add .

git commit -m "Add learner CV builder and profile editor" || true

git push


echo "======================================"
echo " CV Builder Added Successfully"
echo "======================================"

