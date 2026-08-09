
async function loadInventory(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("business_inventory")
.select("*")
.order("created_at",{ascending:false});

document.getElementById("inventory").innerHTML=
(data||[]).map(item=>`

<div class="card">

<h2>${item.product_name}</h2>

<p>
Category:
${item.category || ""}
</p>

<p>
Stock:
${item.stock_quantity || 0}
</p>

<p>
Price:
PKR ${item.unit_price || 0}
</p>

<p>
${item.description || ""}
</p>

</div>

`).join("");

}

document.addEventListener(
"DOMContentLoaded",
loadInventory
);

