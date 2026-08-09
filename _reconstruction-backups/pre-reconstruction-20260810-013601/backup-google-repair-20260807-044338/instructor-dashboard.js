async function loadInstructorDashboard(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:{user}}=await client.auth.getUser();

if(!user){
location.href="/login.html";
return;
}


const {data:courses}=await client

.from("instructor_courses")

.select("*")

.order("created_at",{ascending:false});


document.getElementById("course-list").innerHTML=

(courses||[]).map(course=>`

<div class="card">

<h2>${course.title}</h2>

<p>${course.description || ""}</p>

<p>
Status: ${course.status}
</p>

</div>

`).join("");


}


document.addEventListener(
"DOMContentLoaded",
loadInstructorDashboard
);
