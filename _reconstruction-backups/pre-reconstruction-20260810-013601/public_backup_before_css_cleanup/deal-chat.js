
const params=
new URLSearchParams(location.search);

const roomId=
params.get("room");


async function loadMessages(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data}=await client
.from("deal_messages")
.select("*")
.eq("room_id",roomId)
.order("created_at");


document.getElementById("messages")
.innerHTML=

(data||[]).map(m=>`

<p>
<b>${m.sender_platform_id}</b>:
${m.message}
</p>

`).join("");

}



async function sendMessage(){

const user=
JSON.parse(
localStorage.getItem("user")||"null"
);


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


await client
.from("deal_messages")
.insert({

room_id:roomId,

sender_platform_id:
user.id,

message:
document.getElementById("message").value,

ai_summary:
"AI pending analysis"

});


loadMessages();

}



async function requestMeeting(){

alert(
"Meeting request sent for mutual consent"
);

}



document.addEventListener(
"DOMContentLoaded",
loadMessages
);


