async function showMarketplace(){

let offers =
await loadBusinessOffers();


document.getElementById("businessOffers")
.innerHTML =
offers.length
?
offers.map(
o=>`

<div class="card">

<h3>${o.product}</h3>

<p>
Stock: ${o.quantity || ""}
</p>

<p>
Need: ${o.needs || ""}
</p>

<p>
Price: ${o.price || ""}
</p>

</div>

`
).join("")
:
"No business opportunities";

}


showMarketplace();

