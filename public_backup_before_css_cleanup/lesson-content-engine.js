async function loadLessonContent(){

const lang =
localStorage.getItem("language") || "en";


const file =
window.location.pathname
.split("/")
.pop()
.replace(".html","");


const url =
`/translations/${file}-${lang}.json`;


try {

const response = await fetch(url);


if(!response.ok){
return;
}


const data =
await response.json();


document
.querySelectorAll("[data-lesson-key]")
.forEach(element=>{

const key =
element.getAttribute("data-lesson-key");


if(data[key]){

element.innerHTML=data[key];

}

});


}
catch(error){

console.log("Translation loading skipped");

}

}



document.addEventListener(
"DOMContentLoaded",
loadLessonContent
);
