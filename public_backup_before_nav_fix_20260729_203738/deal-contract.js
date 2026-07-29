
async function saveContract(){

const room =
new URLSearchParams(location.search)
.get("room");


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client
.from("deal_contracts")
.insert({

room_id:room,

contract_title:
document.getElementById("title").value,

contract_content:
document.getElementById("content").value

});



document.getElementById("result").innerHTML=

error ?

error.message :

"Contract draft created";

}

