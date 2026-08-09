async function addProduct(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const user=JSON.parse(
localStorage.getItem("user")||"null"
);

if(!user)return;

let {data:business}=await client
.from("business_profiles")
.select("id")
.eq("user_id",user.id)
.single();


const {error}=await client
.from("business_products")
.insert({

business_id:business.id,

product_name:
document.getElementById("name").value,

category:
document.getElementById("category").value,

price:
document.getElementById("price").value,

stock:
document.getElementById("stock").value,

description:
document.getElementById("description").value,

status:"draft"

});


document.getElementById("msg").innerHTML=
error ? error.message :
"Product saved as draft";

loadProducts();

}



async function loadProducts(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const user=JSON.parse(
localStorage.getItem("user")||"null"
);


let {data:business}=await client
.from("business_profiles")
.select("id")
.eq("user_id",user.id)
.single();


let {data}=await client
.from("business_products")
.select("*")
.eq("business_id",business.id);


document.getElementById("products").innerHTML=

(data||[]).map(p=>`

<div class="card">

<h3>${p.product_name}</h3>

<p>${p.description}</p>

<p>
Price: PKR ${p.price}
</p>

<p>
Stock: ${p.stock}
</p>

<p>
Status: ${p.status}
</p>

</div>

`).join("");

}


document.addEventListener(
"DOMContentLoaded",
loadProducts
);
