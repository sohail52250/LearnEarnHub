async function loadLanguage(lang){

const response = await fetch(
`/translations/${lang}.json`
);

const translations = await response.json();


document.querySelectorAll("[data-key]")
.forEach(element=>{

const key = element.getAttribute("data-key");

if(translations[key]){

element.innerHTML = translations[key];

}

});

localStorage.setItem(
"language",
lang
);

}



function changeLanguage(lang){

loadLanguage(lang);

}


document.addEventListener(
"DOMContentLoaded",
()=>{

const lang =
localStorage.getItem("language") || "en";

loadLanguage(lang);

});
