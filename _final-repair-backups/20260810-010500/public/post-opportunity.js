async function postOpportunity(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;


const opportunity={

employer_id:userData.user.id,

title:
document.getElementById("title").value,

type:
document.getElementById("type").value,

skills:
document.getElementById("skills").value,

description:
document.getElementById("description").value,

reward:
document.getElementById("reward").value,

created_at:
new Date()

};



const {error}=await client
.from("opportunities")
.insert(opportunity);



document.getElementById("message")
.innerHTML =
error ?
"Unable to post opportunity"
:
"Opportunity posted successfully";

}


window.postOpportunity=postOpportunity;
