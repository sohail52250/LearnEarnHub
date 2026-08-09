const lessons = [
  "word-basics",
  "excel-basics",
  "powerpoint-basics",
  "html-basics",
  "css-basics"
];

function nextLesson(current){
  let index = lessons.indexOf(current);

  if(index < lessons.length - 1){
    window.location = "/course-player.html?id=" + lessons[index + 1];
  }else{
    alert("Course completed! Certificate unlocked.");
    window.location = "/certificate.html";
  }
}

function previousLesson(current){
  let index = lessons.indexOf(current);

  if(index > 0){
    window.location = "/course-player.html?id=" + lessons[index - 1];
  }
}
