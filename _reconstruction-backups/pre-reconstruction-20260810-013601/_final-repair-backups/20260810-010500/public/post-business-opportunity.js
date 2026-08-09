
async function postOpportunity(){


let session=
await supabaseClient.auth.getSession();


let user=session.data.session?.user;


if(!user){

location.href="/login.html";
return;

}



let {error}=await supabaseClient
.from("business_opportunities")
.insert({

business_id:user.id,

title:title.value,

description:description.value,

contact:contact.value

});



status.innerHTML =
error
?
"❌ "+error.message
:
"✅ Opportunity published";


}


