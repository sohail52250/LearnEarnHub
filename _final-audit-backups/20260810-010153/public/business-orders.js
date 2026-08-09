
async function loadOrders(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data}=await client
.from("business_orders")
.select("*")
.order("created_at",{ascending:false});

document.getElementById("orders").innerHTML=
(data||[]).map(o=>`

<div class="card">

<h2>
Order #${o.id}
</h2>

<p>
Status:
${o.status || "pending"}
</p>

<p>
Quantity:
${o.quantity || 0}
</p>

</div>

`).join("");

}

document.addEventListener(
"DOMContentLoaded",
loadOrders
);

