
async function sendMeetingRequest(){

const room =
new URLSearchParams(location.search)
.get("room");


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client
.from("meeting_requests")
.insert({

room_id:room,

meeting_type:
document.getElementById("type").value,

consent_a:false,

consent_b:false

});



document.getElementById("result").innerHTML=

error ?

error.message :

"Meeting request sent. Waiting for both parties consent.";

}

