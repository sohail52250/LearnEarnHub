async function completeCourse(courseId){

const user =
JSON.parse(localStorage.getItem("user")||"null");


if(!user){
alert("Login required");
return;
}


let skills =
await unlockCourseSkill(
user.id,
courseId
);


alert(
"Course completed. New skills unlocked: "
+ skills.join(", ")
);

}

window.completeCourse =
completeCourse;


// Learning Path Unlock Hook
if(typeof unlockNextCourse === "function"){

unlockNextCourse(
localStorage.getItem("user_id"),
courseId
);

}

