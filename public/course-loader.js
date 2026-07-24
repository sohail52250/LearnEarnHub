const courseClient = supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


async function loadDynamicCourses(){

const box=document.getElementById("dynamic-courses");

if(!box)return;


const {data,error}=await courseClient
.from("courses")
.select("*")
.order("created_at",{ascending:false});


if(error){

box.innerHTML="Unable to load courses";

return;

}


if(!data || data.length===0){

box.innerHTML="No new courses available yet";

return;

}


box.innerHTML=data.map(course=>`

<div class="course-card">

<h3>${course.title}</h3>

<p>${course.description}</p>

<span>${course.category || "General"}</span>

<br><br>

<button>
Start Course
</button>

</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadDynamicCourses
);
