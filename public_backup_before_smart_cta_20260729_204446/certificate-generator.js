
async function generateCertificate(courseName){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Please login first");

return;

}


let certificateID =
"LEH-" +
Date.now();


const {error}=await client
.from("certificates")
.insert({

user_id:userData.user.id,

course:courseName,

certificate_id:certificateID

});


if(error){

alert(error.message);

return;

}


document.getElementById(
"certificate-result"
).innerHTML=

"🎓 Certificate Created<br>" +

"Certificate ID: " +

certificateID;


}


