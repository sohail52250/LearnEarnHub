function setLanguage(lang){

document.querySelectorAll("[data-en]")
.forEach(el=>{

el.innerHTML =
lang==="ur"
? el.getAttribute("data-ur")
: el.getAttribute("data-en");

});

localStorage.setItem("language",lang);

}


document.addEventListener("DOMContentLoaded",()=>{

const saved =
localStorage.getItem("language") || "en";

setLanguage(saved);

});
