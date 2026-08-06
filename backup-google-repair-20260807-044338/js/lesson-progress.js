
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

