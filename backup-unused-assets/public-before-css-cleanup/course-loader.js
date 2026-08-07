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

<div class="review-box">

<h4>Rate this course</h4>

<select id="rating-${course.id}">
<option value="5">⭐⭐⭐⭐⭐ Excellent</option>
<option value="4">⭐⭐⭐⭐ Good</option>
<option value="3">⭐⭐⭐ Average</option>
<option value="2">⭐⭐ Needs Improvement</option>
<option value="1">⭐ Poor</option>
</select>

<br>

<textarea 
id="comment-${course.id}"
placeholder="Write your feedback">
</textarea>

<br>

<button onclick="submitReview(${course.id})">
Submit Review
</button>

</div>

</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadDynamicCourses
);


async function loadPopularCourses(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("reviews")
.select("course_id,rating");


if(!data)return;


let counts={};


data.forEach(r=>{

counts[r.course_id]=(counts[r.course_id]||0)+Number(r.rating);

});


console.log("Popular courses:",counts);

}

