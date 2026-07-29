function completeLesson(name){

localStorage.setItem(name,"completed");

alert("Lesson completed! Great job.");

}


function lessonStatus(name){

if(localStorage.getItem(name)=="completed"){

document.getElementById("status").innerHTML =
"✅ Completed";

}

}
