function getCompletedLessons(){

let total = 0;

for(let i=0;i<localStorage.length;i++){

let key = localStorage.key(i);

if(localStorage.getItem(key)=="completed"){
total++;
}

}

return total;

}


function showProgress(){

let completed=getCompletedLessons();

document.getElementById("progress").innerHTML =
"Completed Lessons: "+completed;

}
