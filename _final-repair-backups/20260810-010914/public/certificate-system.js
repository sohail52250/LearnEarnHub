async function saveCourseCompletion(course){

const client=supabase.createClient(
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
lesson:course,
completed:true,
completed_at:new Date()

});


if(error){

console.log(error.message);
return;

}


alert("🎉 Course completed! Certificate unlocked.");

}



async function loadCertificateProgress(){

const box=document.getElementById("certificate-box");

if(!box)return;


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

box.innerHTML="Login to see certificates";

return;

}


const {data}=await client
.from("lesson_progress")
.select("*")
.eq("user_id",userData.user.id);


let completed=data ? data.length : 0;


box.innerHTML=
"Completed Lessons: "+completed+
"<br>Certificates Available: "+
Math.floor(completed/5);

}


document.addEventListener(
"DOMContentLoaded",
loadCertificateProgress
);

