async function loadAds(){

let r = await fetch("/api/ads");

let result = await r.json();

let box=document.getElementById("ads");

box.innerHTML="";


(result.data || []).forEach(ad=>{

box.innerHTML += `

<div class="ad">

<h3>${ad.title_en || ad.title_ur}</h3>

<p>${ad.description_en || ""}</p>

<p>Category: ${ad.category}</p>

<p>Location: ${ad.location}</p>

<p>Contact: ${ad.contact}</p>

</div>

`;

});

}


loadAds();
