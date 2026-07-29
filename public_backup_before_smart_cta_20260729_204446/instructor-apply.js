

async function applyInstructor(){


const client=supabase.createClient(

SUPABASE_URL,

SUPABASE_ANON_KEY

);



const {data:{user}} =
await client.auth.getUser();



if(!user){

alert("Please login first");

location.href="/login.html";

return;

}



const {error}=await client

.from("instructor_applications")

.insert({

user_id:user.id,

full_name:
document.getElementById("name").value,

category:
document.getElementById("category").value,

skills:
document.getElementById("skills").value,

experience:
document.getElementById("experience").value,

portfolio:
document.getElementById("portfolio").value,

certificate_url:
document.getElementById("certificate").value

});



if(error){

alert(error.message);

return;

}



alert(
"Application submitted. Await platform verification."
);


}


