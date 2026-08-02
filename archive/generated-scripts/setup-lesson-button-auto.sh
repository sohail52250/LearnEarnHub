#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Lesson Button Setup ==="

mkdir -p public/js


cat > public/js/lesson-progress.js <<'JS'

async function completeLesson(course_id, lesson_id){

const {data:userData}=await supabaseClient.auth.getUser();


if(!userData.user){

alert("Please login first");

return;

}



const response=await fetch(
"/api/complete-lesson",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

user_id:userData.user.id,
course_id:course_id,
lesson_id:lesson_id

})

});


const result=await response.json();



if(result.success){

alert("Lesson completed ✅");

location.reload();

}else{

alert(result.error || "Error");

}


}


window.completeLesson=completeLesson;

JS



cat > public/lesson-example.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Lesson</title>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<script src="/js/supabase-config.js"></script>

<script src="/js/lesson-progress.js"></script>

</head>


<body>


<h2>Computer Basics - Lesson 1</h2>


<p>
Learn the basics step by step.
</p>


<button onclick="completeLesson(2,1)">
Complete Lesson ✅
</button>


</body>

</html>
HTML



echo "✅ Lesson JavaScript created"
echo "✅ Lesson example page created"

