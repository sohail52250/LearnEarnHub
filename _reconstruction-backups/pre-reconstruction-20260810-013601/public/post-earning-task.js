
async function postTask(){

const user =
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
.from("earning_tasks")
.insert({

creator_id:user.id,

title:
document.getElementById("title").value,

description:
document.getElementById("description").value,

required_skill:
document.getElementById("skill").value,

reward_amount:
document.getElementById("reward").value

});


document.getElementById("message").innerHTML=

error ? error.message :
"Task published";

}

