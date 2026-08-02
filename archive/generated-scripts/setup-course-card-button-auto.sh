#!/data/data/commerce/files/usr/bin/bash

echo "=== LearnEarnHub Course Card Button Setup ==="

mkdir -p public/js


cat > public/js/course-card.js <<'JS'

function createCourseCard(course,user_id){

return `

<div class="course-card">

<h3>${course.title_en}</h3>

<p>${course.category || ""}</p>

<p>
${course.description_en || ""}
</p>


<button onclick="enrollCourse(${course.id},'${user_id}')">

🚀 Start Learning

</button>


</div>

`;

}



async function loadCourses(user_id){


const res=await fetch("/api/courses");

const courses=await res.json();



let html="";


courses.forEach(course=>{

html+=createCourseCard(course,user_id);

});


document.getElementById("courses")
.innerHTML=html;


}


window.loadCourses=loadCourses;


JS



cat > public/courses.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Courses</title>

<script src="/js/enrollment.js"></script>

<script src="/js/course-card.js"></script>


<style>

.course-card{

background:white;
padding:20px;
margin:15px;
border-radius:10px;
box-shadow:0 2px 8px #ccc;

}

button{

padding:10px 15px;
background:#1565c0;
color:white;
border:0;
border-radius:8px;

}

</style>


</head>


<body>


<h1>📚 Courses</h1>


<div id="courses">

Loading...

</div>



<script>


const user_id =
new URLSearchParams(location.search)
.get("user_id");


loadCourses(user_id);


</script>


</body>

</html>
HTML



echo "✅ Course card UI created"

echo ""
echo "Open:"
echo "/courses.html?user_id=YOUR_USER_ID"


