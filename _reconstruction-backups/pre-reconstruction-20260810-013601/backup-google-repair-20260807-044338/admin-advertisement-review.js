
async function loadAds(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("advertisements")
.select("*")
.order("id",{ascending:false});

const box=document.getElementById("ads");

box.innerHTML=(data||[]).map(a=>`

<div class="card">

<h2>${a.title}</h2>

<p>${a.description||""}</p>

<p>Package: ${a.package}</p>

<p>Status: ${a.status}</p>

<p>Payment: ${a.payment_status}</p>

</div>

`).join("");

}

document.addEventListener(
"DOMContentLoaded",
loadAds
);

