
const roomId =
new URLSearchParams(location.search)
.get("room");


async function createSummary(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data,error}=await client
.from("deal_messages")
.select("*")
.eq("room_id",roomId)
.order("created_at");



if(error){

document.getElementById("summary").innerHTML=
error.message;

return;

}



let text =
(data||[])
.map(m=>m.message)
.join("\n");



let summary =
`
AI Deal Summary

Discussion Points:
${text}

Status:
Under Review

Next Steps:
- Confirm requirements
- Prepare proposal
- Schedule meeting
`;



await client
.from("deal_ai_summaries")
.insert({

room_id:roomId,

summary:summary

});



document.getElementById("summary").innerHTML=
summary.replace(/\n/g,"<br>");

}



