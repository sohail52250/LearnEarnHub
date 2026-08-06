async function unlockNextCourse(userId, completedCourseId){

try{

const res = await fetch(
"/api/course/unlock-next",
{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({
user_id:userId,
completed_course_id:completedCourseId
})
}
);


const data = await res.json();

console.log(
"Next course unlock:",
data
);


}catch(error){

console.error(
"Unlock error",
error
);

}

}
