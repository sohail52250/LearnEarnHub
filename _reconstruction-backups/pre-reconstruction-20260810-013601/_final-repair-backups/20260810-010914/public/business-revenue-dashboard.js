
async function loadRevenue(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:orders}=await client
.from("business_orders")
.select("*");

const totalOrders=(orders||[]).length;

document.getElementById("stats").innerHTML=`

<div class="card">

<h2>Total Orders</h2>

<p>${totalOrders}</p>

</div>

`;

}

document.addEventListener(
"DOMContentLoaded",
loadRevenue
);

