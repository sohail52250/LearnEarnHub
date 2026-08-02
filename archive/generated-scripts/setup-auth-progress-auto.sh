#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Auth + Lesson Completion Setup ==="

mkdir -p public/js


cat > public/js/auth-progress.js <<'JS'
const SUPABASE_URL = window.SUPABASE_URL;
const SUPABASE_ANON_KEY = window.SUPABASE_ANON_KEY;

let supabaseClient = supabase.createClient(
  SUPABASE_URL,
  SUPABASE_ANON_KEY
);


async function getCurrentUser(){

 const {data,error}=await supabaseClient.auth.getUser();

 if(error){
   console.log(error);
   return null;
 }

 return data.user;

}



async function completeLesson(course_id,lesson_id){

 const user=await getCurrentUser();

 if(!user){
   alert("Please login first");
   return;
 }


 const res=await fetch("/api/progress/complete",{

 method:"POST",

 headers:{
  "Content-Type":"application/json"
 },

 body:JSON.stringify({

  user_id:user.id,
  course_id,
  lesson_id

 })

 });


 const data=await res.json();

 alert(
 data.message || "Lesson completed"
 );

}


window.completeLesson=completeLesson;
window.getCurrentUser=getCurrentUser;

JS



cat > public/lesson-complete-example.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Lesson Complete</title>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/js/auth-progress.js"></script>
</head>

<body>

<h2>Lesson 1</h2>

<button onclick="completeLesson(2,1)">
Mark Lesson Complete ✅
</button>


</body>
</html>
HTML


echo "✅ Auth progress JS created"
echo "✅ Lesson button example created"

