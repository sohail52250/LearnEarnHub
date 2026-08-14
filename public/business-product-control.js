
async function loadProducts(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){
location.href="/auth/sign-in.html";
return;
}


const {data,error}=await client
.from("business_products")
.select("*")
.eq("business_id",user.id)
.order("created_at",{ascending:false});


if(error){
document.getElementById("products").innerHTML=error.message;
return;
}


document.getElementById("products").innerHTML=

(data||[]).map(p=>`

<div class="card">

<h2>${p.product_name}</h2>

<p>
Status: ${p.status}
</p>

<p>
Stock: ${p.stock}
</p>

<p>
Price: Rs ${p.price}
</p>


<button onclick="publishProduct('${p.id}')">
✅ Publish
</button>


<button onclick="hideProduct('${p.id}')">
👁 Hide
</button>


</div>

`).join("")
||
"No products";


}



async function publishProduct(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("business_products")
.update({
status:"published"
})
.eq("id",id);


loadProducts();

}



async function hideProduct(id){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("business_products")
.update({
status:"draft"
})
.eq("id",id);


loadProducts();

}


document.addEventListener(
"DOMContentLoaded",
loadProducts
);

