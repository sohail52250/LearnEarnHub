async function loadBusinessStats(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

let offers=0;
let ads=0;
let inventory=0;

try{

const r1=await client
.from("business_offers")
.select("*",{count:"exact",head:true});

offers=r1.count||0;

}catch(e){}

try{

const r2=await client
.from("advertisements")
.select("*",{count:"exact",head:true});

ads=r2.count||0;

}catch(e){}

try{

const r3=await client
.from("business_inventory")
.select("*",{count:"exact",head:true});

inventory=r3.count||0;

}catch(e){}

const box=document.getElementById("business-stats");

if(!box)return;

box.innerHTML=`

<div class="card">

<h2>📈 Business Network</h2>

<p>📢 Business Offers: ${offers}</p>

<p>📦 Inventory Items: ${inventory}</p>

<p>📣 Advertisements: ${ads}</p>

</div>

`;

}

document.addEventListener(
"DOMContentLoaded",
loadBusinessStats
);
