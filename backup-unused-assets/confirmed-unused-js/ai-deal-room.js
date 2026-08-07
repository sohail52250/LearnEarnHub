
async function sendDealMessage(data){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:result,error}=await client
.from("deal_messages")
.insert(data)
.select();


if(error){

console.log(error);
return null;

}


return result;

}



async function requestMeeting(data){

const client =
supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


return await client
.from("deal_meeting_requests")
.insert(data);

}



window.sendDealMessage=sendDealMessage;
window.requestMeeting=requestMeeting;

