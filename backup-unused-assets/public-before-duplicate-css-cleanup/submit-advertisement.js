
async function submitAdvertisement(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data:{user}}=
await client.auth.getUser();

if(!user){
alert("Login required");
return;
}

const {error}=await client
.from("advertisements")
.insert({

business_id:user.id,

title:
document.getElementById("title").value,

description:
document.getElementById("description").value,

package:
document.getElementById("package").value,

status:"pending",

payment_status:"pending"

});

document.getElementById("msg").innerHTML=
error
? error.message
: "Advertisement submitted for review";

}

window.submitAdvertisement=
submitAdvertisement;

