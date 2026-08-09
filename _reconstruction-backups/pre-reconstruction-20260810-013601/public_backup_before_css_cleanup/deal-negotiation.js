
async function sendOffer(){

const roomId =
new URLSearchParams(location.search)
.get("room");


const user =
JSON.parse(
localStorage.getItem("user") || "null"
);


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client
.from("deal_negotiations")
.insert({

room_id:roomId,

sender_id:user.id,

offer_type:"offer",

offer_amount:
document.getElementById("amount").value,

message:
document.getElementById("message").value

});



document.getElementById("result").innerHTML=

error ?

error.message :

"Offer submitted for AI review";

}

