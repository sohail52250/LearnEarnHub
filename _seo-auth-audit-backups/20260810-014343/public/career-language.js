async function loadCareerLanguage(){

const lang =
localStorage.getItem("language") || "en";


const page =
location.pathname.includes("career-profile")
?
"career-profile"
:
"opportunities";


const response =
await fetch(
`/translations/${page}-${lang}.json`
);


if(!response.ok) return;


const t =
await response.json();


document.querySelectorAll("[data-key]")
.forEach(el=>{

const key=el.dataset.key;

if(t[key]){

el.innerHTML=t[key];

}

});

}

document.addEventListener(
"DOMContentLoaded",
loadCareerLanguage
);
