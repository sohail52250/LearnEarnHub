
async function submitBusinessDeal(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=
JSON.parse(localStorage.getItem("user")||"null");


if(!user){

alert("Login required");

return;

}


const {error}=await client
.from("business_deal_requests")
.insert({

owner_id:user.id,

request_type:
document.getElementById("type").value,

company_name:
document.getElementById("company").value,

industry:
document.getElementById("industry").value,

description:
document.getElementById("description").value,

requirements:
document.getElementById("requirements").value,

expected_value:
document.getElementById("value").value

});


document.getElementById("result").innerHTML=

error ?

error.message :

"Business request submitted for review";


}

