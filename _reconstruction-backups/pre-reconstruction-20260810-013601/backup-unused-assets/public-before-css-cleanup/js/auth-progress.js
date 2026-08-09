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

