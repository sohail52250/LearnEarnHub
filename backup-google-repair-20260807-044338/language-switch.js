
let currentLanguage =
localStorage.getItem("language") || "en";


async function setLanguage(lang){

localStorage.setItem(
"language",
lang
);

currentLanguage=lang;

await loadLanguage();

}



async function loadLanguage(){

const response =
await fetch(
`/translations/${currentLanguage}.json`
);


const words =
await response.json();



document.querySelectorAll("[data-key]")
.forEach(el=>{

let key =
el.getAttribute("data-key");


if(words[key]){

el.innerHTML =
words[key];

}

});



if(currentLanguage==="ur" ||
currentLanguage==="ar"){

document.documentElement.dir="rtl";

}else{

document.documentElement.dir="ltr";

}


}



document.addEventListener(
"DOMContentLoaded",
loadLanguage
);


window.setLanguage=setLanguage;

