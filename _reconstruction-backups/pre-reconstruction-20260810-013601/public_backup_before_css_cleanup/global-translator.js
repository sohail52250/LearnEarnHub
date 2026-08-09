
async function loadTranslations(){

const lang=
localStorage.getItem("language") || "en";

try{

const response=
await fetch(`/translations/${lang}.json`);

const words=
await response.json();

document
.querySelectorAll("[data-key]")
.forEach(el=>{

const key=
el.getAttribute("data-key");

if(words[key]){
el.innerHTML=words[key];
}

});

if(lang==="ur" || lang==="ar"){
document.documentElement.dir="rtl";
}else{
document.documentElement.dir="ltr";
}

}catch(e){
console.log(e);
}

}

document.addEventListener(
"DOMContentLoaded",
loadTranslations
);

