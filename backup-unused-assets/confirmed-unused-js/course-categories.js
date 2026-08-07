function filterCategory(category){

let courses=document.querySelectorAll(".course-card");

courses.forEach(function(course){

if(category==="all" ||
course.innerText.toLowerCase().includes(category.toLowerCase())){

course.style.display="block";

}else{

course.style.display="none";

}

});

}
