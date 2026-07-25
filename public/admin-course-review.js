
async function loadCourseReviews(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data,error}=await client

.from("course_reviews")

.select("*")

.eq("status","pending");



const box=document.getElementById(
"course-list"
);



if(error){

box.innerHTML="Unable to load reviews";

return;

}



box.innerHTML=(data || []).map(c=>`

<div class="card">

<h2>
Course ID:
${c.course_id}
</h2>


<p>
AI Score:
${c.ai_score}/100
</p>


<p>
Status:
${c.status}
</p>


<button onclick="approveCourse('${c.id}')">

Approve

</button>


<button onclick="rejectCourse('${c.id}')">

Reject

</button>


</div>


`).join("");

}



async function approveCourse(id){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



await client

.from("course_reviews")

.update({

status:"approved",

updated_at:new Date()

})

.eq("id",id);



alert("Course approved");


loadCourseReviews();

}




async function rejectCourse(id){


const note =
prompt("Reason for rejection");



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



await client

.from("course_reviews")

.update({

status:"rejected",

review_notes:note,

updated_at:new Date()

})

.eq("id",id);



alert("Course rejected");


loadCourseReviews();


}



document.addEventListener(
"DOMContentLoaded",
loadCourseReviews
);


