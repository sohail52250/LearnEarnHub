
async function loadMarketplace(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const box=document.getElementById(
"marketplace-courses"
);


if(!box)return;


const {data,error}=await client
.from("course_catalog")
.select("*")
.order("featured",{ascending:false});


if(error){

box.innerHTML="Unable to load courses";

return;

}


box.innerHTML=data.map(course=>`

<div class="course-card">


${course.featured ? 
"<h4>⭐ Featured Course</h4>" : ""}


<h2>${course.title}</h2>


<p>${course.description}</p>


<p>
Category: ${course.category || "General"}
</p>


<p>
Level: ${course.level || "Beginner"}
</p>


<p>
${course.price==0 ?
"🆓 Free Course" :
"💰 Premium Course"
}
</p>


<button>
Start Learning
</button>


</div>

`).join("");


}


document.addEventListener(
"DOMContentLoaded",
loadMarketplace
);

