
async function loadReviewQueue(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:courses}=await client
.from("courses")
.select("*")
.order("created_at",{ascending:false});

const box=document.getElementById("reviewQueue");

box.innerHTML=(courses||[]).map(course=>`

<div class="card">

<h2>${course.title}</h2>

<p>${course.description||""}</p>

<p>Category: ${course.category||"General"}</p>

<button onclick="approveCourse(${course.id})">
✅ Approve
</button>

<button onclick="rejectCourse(${course.id})">
❌ Reject
</button>

</div>

`).join("");

}

async function approveCourse(courseId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

await client
.from("course_reviews")
.insert({
course_id:courseId,
review_status:"approved",
quality_score:90
});

alert("Course approved");
location.reload();

}

async function rejectCourse(courseId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

await client
.from("course_reviews")
.insert({
course_id:courseId,
review_status:"rejected",
quality_score:30
});

alert("Course rejected");
location.reload();

}

document.addEventListener(
"DOMContentLoaded",
loadReviewQueue
);

