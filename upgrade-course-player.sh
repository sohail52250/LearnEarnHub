#!/data/data/com.termux/files/usr/bin/bash

echo "=== Backup course player ==="

cp public/course-player.html public/course-player.before-lessons.html

echo "=== Updating course player JS ==="

cat > public/course-player-lessons.js <<'JS'
let lang = localStorage.getItem("language") || "en";

async function loadCourse(){

const params=new URLSearchParams(location.search);
const id=params.get("id");

if(!id) return;

const res=await fetch("/api/courses");
const courses=await res.json();

const course=courses.find(c=>c.id==id);

if(!course) return;


document.getElementById("course-title").innerText =
course["title_"+lang] ||
course.title_en;


document.getElementById("course-description").innerText =
course["description_"+lang] ||
course.description_en;


loadLessons(id);

}


async function loadLessons(courseId){

const res=await fetch(
"/api/course-lessons/"+courseId
);

const lessons=await res.json();

const box=document.getElementById("lessons");

box.innerHTML="";


lessons.forEach(l=>{

let title =
l["title_"+lang] ||
l.title_en;


let content =
l["content_"+lang] ||
l.content_en;


box.innerHTML += `

<div class="lesson-card">

<h3>${title}</h3>

<p>${content}</p>

<button onclick="completeLesson(${l.id})">
Complete Lesson
</button>

</div>

`;

});

}



async function completeLesson(id){

await fetch(
"/api/lesson-progress",
{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({
lesson_id:id
})
}
);

alert("Lesson completed");

}


document.addEventListener(
"DOMContentLoaded",
loadCourse
);

JS


echo "=== Created course-player-lessons.js ==="

echo "Done"
