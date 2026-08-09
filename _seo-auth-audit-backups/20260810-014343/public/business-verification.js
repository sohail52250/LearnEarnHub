
async function submitVerification(){

const user=
JSON.parse(localStorage.getItem("user")||"null");


if(!user){

alert("Login required");

return;

}


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {error}=await client
.from("business_verification_requests")
.insert({

user_id:user.id,

business_name:
document.getElementById("name").value,

registration_number:
document.getElementById("reg").value,

country:
document.getElementById("country").value,

document_url:
document.getElementById("document").value

});



document.getElementById("message").innerHTML=

error ?

error.message :

"Verification request submitted";

}


