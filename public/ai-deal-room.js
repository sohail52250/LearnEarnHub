
async function loadDealRoom(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){
document.getElementById("room").innerHTML=
"Login required";
return;
}


const {data,error}=await client
.from("deal_rooms")
.select("*")
.or(
`party_one_id.eq.${user.id},party_two_id.eq.${user.id}`
);


if(error){
document.getElementById("room").innerHTML=
error.message;
return;
}


document.getElementById("room").innerHTML=

data.length ?

data.map(r=>`

<div class="card">

<h3>
🔐 Deal Room #${r.id}
</h3>

<p>
Status:
${r.status}
</p>

<p>
AI Assistance:
Enabled
</p>


<button onclick="openChat(${r.id})">
Open Secure Conversation
</button>


</div>

`).join("")

:

"No active deal rooms";


}



function openChat(id){

location.href=
"/deal-chat.html?room="+id;

}



document.addEventListener(
"DOMContentLoaded",
loadDealRoom
);

