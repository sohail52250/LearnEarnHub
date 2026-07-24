async function completeLesson(lessonName){

const client = supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Please login first");
return;

}


const {error}=await client
.from("lesson_progress")
.insert({

user_id:userData.user.id,
lesson:lessonName,
completed:true

});


if(error){

alert(error.message);
return;

}


alert("Lesson completed!");

loadProgress();

}



async function loadProgress(){

const box=document.getElementById("progress-box");

if(!box) return;


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

box.innerHTML="Login to view progress";

return;

}


const {data}=await client
.from("lesson_progress")
.select("*")
.eq("user_id",userData.user.id);


box.innerHTML =
"Completed Lessons: "+(data ? data.length : 0);

}


document.addEventListener(
"DOMContentLoaded",
loadProgress
);
