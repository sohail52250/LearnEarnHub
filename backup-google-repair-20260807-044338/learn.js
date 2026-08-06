async function loadCourses(){

let r=await fetch("/api/courses");

let result=await r.json();

let box=document.getElementById("courses");

box.innerHTML="";


(result.data || []).forEach(course=>{

box.innerHTML += `

<div class="course">

<h2>${course["title_"+(localStorage.getItem("language")||"en")] || course.title_en}</h2>

<p>${course["description_"+(localStorage.getItem("language")||"en")] || course.description_en}</p>

<p>Earn Points: ⭐ ${course.points}</p>

<button>
Start Learning
</button>

</div>

`;

});

}

loadCourses();
