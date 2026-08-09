
async function enrollCourse(course_id,user_id){


const res=await fetch(
"/api/enrollment",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"enroll",

course_id,

user_id

})

});


const data=await res.json();


alert(
data.course_id
?
"Course enrolled ✅"
:
"Enrollment failed"
);


location.reload();


}


window.enrollCourse=enrollCourse;

