
async function addProduct(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:{user}}=
await client.auth.getUser();

if(!user){
alert("Login required");
return;
}


const {error}=await client
.from("business_products")
.insert({

business_id:user.id,

product_name:
document.getElementById("name").value,

category:
document.getElementById("category").value,

description:
document.getElementById("description").value,

stock:
Number(document.getElementById("stock").value),

price:
Number(document.getElementById("price").value),

image_url:
document.getElementById("image").value

});


document.getElementById("msg").innerHTML=
error ? error.message :
"Product published successfully";

}

window.addProduct=addProduct;

