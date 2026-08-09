
async function sendInquiry(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

alert("Please login first");
return;

}


const {error}=await client
.from("business_inquiries")
.insert({

sender_id:user.id,

business_id:
document.getElementById("business_id").value,

message:
document.getElementById("message").value,

status:"pending",

created_at:new Date()

});


document.getElementById("result").innerHTML =
error
?
"Failed to send inquiry"
:
"✅ Inquiry sent successfully";


}


window.sendInquiry=sendInquiry;

