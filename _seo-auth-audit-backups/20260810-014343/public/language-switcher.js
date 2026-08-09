async function loadLanguage(lang){

if(!lang){
lang=localStorage.getItem("leh_lang") || "en";
}

localStorage.setItem("leh_lang",lang);
localStorage.setItem("language",lang);

try{

const response=await fetch(`/translations/${lang}.json`);

const translations=await response.json();


document.querySelectorAll("[data-i18n]").forEach(el=>{
let key=el.dataset.i18n;
if(translations[key]){
el.innerHTML=translations[key];
}
});


document.querySelectorAll("[data-key]").forEach(el=>{
let key=el.dataset.key;
if(translations[key]){
el.innerHTML=translations[key];
}
});


document.documentElement.lang=lang;


if(lang==="ur" || lang==="ar"){
document.documentElement.dir="rtl";
}else{
document.documentElement.dir="ltr";
}


}catch(e){
console.log("Language error:",e);
}

}


window.addEventListener("DOMContentLoaded",()=>{
loadLanguage();
});

window.loadLanguage=loadLanguage;
