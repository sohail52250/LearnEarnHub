
async function sendFeedback(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const name=document.getElementById("feedback-name").value;

const email=document.getElementById("feedback-email").value;

const message=document.getElementById("feedback-message").value;


const {error}=await client
.from("feedback")
.insert({

name:name,

email:email,

message:message

});


if(error){

alert(error.message);

return;

}


alert("Thank you for your feedback! ⭐");


document.getElementById("feedback-message").value="";

}

