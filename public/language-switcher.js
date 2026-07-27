
async function loadLanguage(lang){

localStorage.setItem("leh_lang",lang);

try{

const response = await fetch(
`/translations/${lang}.json`
);

const translations = await response.json();

document.querySelectorAll("[data-i18n]")
.forEach(el=>{

const key = el.dataset.i18n;

if(translations[key]){
el.innerHTML = translations[key];
}

});

document.documentElement.lang = lang;

if(lang==="ar"){
document.body.dir="rtl";
}
else{
document.body.dir="ltr";
}

}catch(e){

console.log("Translation load error",e);

}

}

window.addEventListener("DOMContentLoaded",()=>{

const saved =
localStorage.getItem("leh_lang") || "en";

loadLanguage(saved);

});

