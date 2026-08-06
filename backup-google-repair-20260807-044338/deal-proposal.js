
async function submitProposal(){

const roomId =
new URLSearchParams(location.search)
.get("room");


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {error}=await client
.from("deal_proposals")
.insert({

room_id:roomId,

proposal:
document.getElementById("proposal").value,

status:"pending"

});


document.getElementById("result").innerHTML=

error ?

error.message :

"Proposal submitted";


}

