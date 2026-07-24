
const client = supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


async function addCourse(){

let title=document.getElementById("courseTitle").value;

let category=document.getElementById("courseCategory").value;

let description=document.getElementById("courseDescription").value;


const {error}=await client
.from("courses")
.insert({

title:title,
category:category,
description:description

});


if(error){

alert(error.message);
return;

}


document.getElementById("admin-message")
.innerHTML="Course added successfully";


loadCourses();

}



async function loadCourses(){

let box=document.getElementById("admin-courses");

if(!box)return;


const {data}=await client
.from("courses")
.select("*");


if(!data){

box.innerHTML="No courses found";
return;

}


box.innerHTML=data.map(course=>`

<div class="card">

<h3>${course.title}</h3>

<p>${course.description}</p>

</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadCourses
);

