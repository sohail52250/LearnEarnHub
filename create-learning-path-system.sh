#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating LearnEarnHub Learning Path System ==="

mkdir -p public

cat > public/learning-path.js <<'JS'
async function loadLearningPath(){

const user = JSON.parse(localStorage.getItem("user") || "{}");

if(!user.id){
    console.log("No learner logged in");
    return;
}

const box=document.getElementById("learning-path");

if(!box) return;


try{

const response = await fetch(
`/api/learning-path/${user.id}`
);

const data = await response.json();


let html="<h2>My Learning Path</h2>";


(data.courses || []).forEach(course=>{

if(course.completed){

html += `
<div class="course complete">
✅ ${course.title}
<br>
<small>Completed</small>
</div>
`;

}
else if(course.unlocked){

html += `
<div class="course unlocked">
🔓 ${course.title}
<br>
<button onclick="startCourse(${course.id})">
Start Learning
</button>
</div>
`;

}
else{

html += `
<div class="course locked">
🔒 ${course.title}
<br>
<small>Complete previous course first</small>
</div>
`;

}

});


box.innerHTML=html;


}catch(e){

console.error(e);

box.innerHTML="Unable to load learning path";

}

}


function startCourse(id){

window.location.href=
"/course-player.html?id="+id;

}


document.addEventListener(
"DOMContentLoaded",
loadLearningPath
);
JS


cat > public/learning-path.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>My Learning Path</title>
</head>

<body>

<h1>LearnEarnHub Learning Journey</h1>

<div id="learning-path">
Loading...
</div>

<script src="/learning-path.js"></script>

</body>
</html>
HTML


echo "Learning Path frontend created"

echo "=== Complete ==="

