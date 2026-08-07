async function loadRewardsLanguage(){

const lang =
localStorage.getItem("language") || "en";

const response =
await fetch(`/translations/rewards-${lang}.json`);

if(!response.ok) return;

const data =
await response.json();

document
.querySelectorAll("[data-reward-key]")
.forEach(el=>{

const key =
el.getAttribute("data-reward-key");

if(data[key]){
el.innerHTML=data[key];
}

});

}

document.addEventListener(
"DOMContentLoaded",
loadRewardsLanguage
);
