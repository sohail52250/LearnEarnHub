function completeLesson(name){
 localStorage.setItem(name,"completed");
 alert("Lesson completed!");
}

function checkProgress(name){
 if(localStorage.getItem(name)){
   return "✅ Completed";
 }
 return "⏳ Not completed";
}
