function enroll(course){

let courses =
JSON.parse(localStorage.getItem("courses") || "[]");


if(!courses.includes(course)){

courses.push(course);

localStorage.setItem(
"courses",
JSON.stringify(courses)
);

alert("Course enrolled successfully!");

}else{

alert("Already enrolled");

}

}


function loadCourses(){

let box=document.getElementById("myCourses");

let courses =
JSON.parse(localStorage.getItem("courses") || "[]");


if(courses.length===0){

box.innerHTML=
"No courses enrolled yet / ابھی کوئی کورس منتخب نہیں";

return;

}


box.innerHTML="";


courses.forEach(c=>{

let p=document.createElement("p");

p.innerHTML="✅ "+c;

box.appendChild(p);

});


}
