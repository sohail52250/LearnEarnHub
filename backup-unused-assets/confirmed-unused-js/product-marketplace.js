
async function loadProducts(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("business_products")
.select("*")
.eq("status","active")
.order("created_at",{ascending:false});


document.getElementById("products").innerHTML=

(data||[]).map(p=>`

<div class="card">

<h2>
${p.product_name}
</h2>


<img src="${p.image_url||''}" width="150">


<p>
Category:
${p.category||""}
</p>


<p>
${p.description||""}
</p>


<p>
📦 Stock:
${p.stock}
</p>


<p>
💰 Price:
PKR ${p.price||0}
</p>


</div>

`).join("");


}


document.addEventListener(
"DOMContentLoaded",
loadProducts
);

