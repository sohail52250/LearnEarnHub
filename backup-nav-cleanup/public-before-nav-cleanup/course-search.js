
function searchCourses(){

let input=document
.getElementById("courseSearch")
.value
.toLowerCase();


let cards=document
.querySelectorAll(".course-card");


cards.forEach(card=>{

let text=card.innerText.toLowerCase();


if(text.includes(input)){

card.style.display="block";

}else{

card.style.display="none";

}

});


}

