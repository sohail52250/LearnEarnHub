
async function loadBusinessStats(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const offers=await client
.from("business_offers")
.select("*",{count:"exact",head:true});

const ads=await client
.from("advertisements")
.select("*",{count:"exact",head:true});

const inventory=await client
.from("business_inventory")
.select("*",{count:"exact",head:true});

document.getElementById("business-stats").innerHTML=`

<div class="card">

<h2>📈 Business Network</h2>

<p>📢 Offers: ${offers.count||0}</p>

<p>📦 Products: ${inventory.count||0}</p>

<p>📣 Advertisements: ${ads.count||0}</p>

</div>

`;

}

document.addEventListener(
"DOMContentLoaded",
loadBusinessStats
);

