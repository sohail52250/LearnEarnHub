
async function openNext(){

let res=await fetch(
`/api/next-lesson?action=next&course_id=${course_id}&lesson_order=${lesson_order}`
);


let next=await res.json();


if(next){

location.href=
`/lesson.html?user_id=${user_id}&course_id=${course_id}&lesson_order=${next.lesson_order}`;

}else{

alert("🎉 Course lessons completed");

}

}



async function checkCourseComplete(){


let res=await fetch(
`/api/next-lesson?action=completion&user_id=${user_id}&course_id=${course_id}`
);


let data=await res.json();


if(data.completed){

alert("🏆 Course completed! Certificate ready");

}


}

