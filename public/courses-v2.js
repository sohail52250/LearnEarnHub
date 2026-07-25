
let allCourses=[];


async function loadCourses(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data,error}=await client
.from("courses")
.select("*")
.order("created_at",{ascending:false});



if(error){

document.getElementById("courses").innerHTML=
"Unable to load courses";

return;

}


allCourses=data || [];

displayCourses(allCourses);


}



function displayCourses(courses){


document.getElementById("courses").innerHTML=


courses.map(course=>`

<div class="card">


<h2>
📘 ${course.title}
</h2>


<p>
${course.description}
</p>


<p>
🏷 Category:
${course.category}
</p>


<p>
📊 Level:
${course.level}
</p>


<p>
👨‍🏫 Instructor:
${course.instructor}
</p>


<p>
⭐ ${course.rating}
|
👥 ${course.students} students
</p>



<a href="/course-player.html?id=${course.id}">

<button>
Start Learning
</button>

</a>


</div>


`).join("");

}



function searchCourses(){


const text=document
.getElementById("search")
.value
.toLowerCase();



displayCourses(

allCourses.filter(c=>

c.title.toLowerCase()
.includes(text)

)

);


}



document.addEventListener(
"DOMContentLoaded",
loadCourses
);


