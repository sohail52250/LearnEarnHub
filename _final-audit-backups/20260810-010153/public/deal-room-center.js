
const client=supabaseClient;



async function loadRooms(){


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

document.body.innerHTML=
"Please login";

return;

}



const {data}=await client

.from("deal_rooms")

.select("*")

.or(
`party_one_id.eq.${user.id},party_two_id.eq.${user.id}`
);



document.getElementById("rooms").innerHTML=

(data||[])
.map(r=>`

<div>

<h3>
Room #${r.id}
</h3>

<p>
Status:
${r.status}
</p>

<p>
Fee:
${r.fee_status}
</p>

<a href="/deal-room.html?id=${r.id}">
Open Room
</a>

</div>

`)

.join("")

||
"No rooms available";


}



document.addEventListener(
"DOMContentLoaded",
loadRooms
);

