async function postBusinessOffer(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user)return;



const {error}=await client
.from("business_offers")
.insert({

user_id:userData.user.id,

business_name:
document.getElementById("business-name").value,

category:
document.getElementById("category").value,

offer:
document.getElementById("offer").value,

stock:
document.getElementById("stock").value,

need:
document.getElementById("need").value,

provide:
document.getElementById("provide").value,

details:
document.getElementById("details").value,

created_at:new Date()

});



document.getElementById("message")
.innerHTML=

error ?
"Failed to publish"
:
"Business opportunity published";


}


window.postBusinessOffer=
postBusinessOffer;
