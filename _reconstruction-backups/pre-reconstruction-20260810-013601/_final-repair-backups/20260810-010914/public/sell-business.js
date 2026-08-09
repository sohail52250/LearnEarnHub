
async function submitBusinessSale(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user")||"null"
);


if(!user){

alert("Login required");
return;

}



const {error}=await client
.from("business_sale_listings")
.insert({

owner_id:user.id,

business_name:
document.getElementById("business_name").value,

category:
document.getElementById("category").value,

description:
document.getElementById("description").value,

years_operating:
Number(document.getElementById("years").value),

asking_price:
Number(document.getElementById("price").value),

assets:
document.getElementById("assets").value,

reason_for_sale:
document.getElementById("reason").value,

status:"draft"

});



document.getElementById("message").innerHTML=

error
?
error.message
:
"✅ Business submitted for review";


}


window.submitBusinessSale=
submitBusinessSale;

