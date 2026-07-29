
async function loadBusinessOffers(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("business_needs")
.select("*")
.order("created_at",{ascending:false});

const box=
document.getElementById("business-list");

if(!data || !data.length){

box.innerHTML=
"No active business needs.";

return;

}

box.innerHTML=data.map(item=>`

<div class="card">

<h2>
${item.need_title}
</h2>

<p>
Category:
${item.category}
</p>

<p>
Budget:
${item.budget || "Not specified"}
</p>

<p>
Location:
${item.location || "Remote"}
</p>

<p>
Quantity:
${item.quantity || "Flexible"}
</p>

<p>
Status:
${item.status || "Open"}
</p>

</div>

`).join("");

}

document.addEventListener(
"DOMContentLoaded",
loadBusinessOffers
);

