
async function requestPayment(){

const user =
JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.getElementById("message").innerHTML=
"Login required";

return;

}


const amount =
document.getElementById("package").value;


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const room =
new URLSearchParams(location.search)
.get("room");



const {error}=await client
.from("deal_payments")
.insert({

room_id:room,

payer_id:user.id,

amount:amount,

currency:"PKR",

payment_status:"pending"

});



document.getElementById("message").innerHTML=

error ?

error.message :

"Payment request created. Waiting for confirmation.";

}


