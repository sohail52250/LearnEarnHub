
async function addProduct(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

alert("Login required");
return;

}


const {error}=await client
.from("business_products")
.insert({

business_id:user.id,

product_name:
document.getElementById("product_name").value,

category:
document.getElementById("category").value,

description:
document.getElementById("description").value,

stock:
Number(document.getElementById("stock").value),

price:
Number(document.getElementById("price").value),

image_url:
document.getElementById("image_url").value,

status:"active",

created_at:new Date()

});


document.getElementById("message").innerHTML=

error
?
"Failed to add product"
:
"✅ Product published";


}


window.addProduct=addProduct;

