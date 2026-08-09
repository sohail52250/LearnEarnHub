async function requestAd(packageName,amount){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){
location.href="/login.html";
return;
}


const {error}=await client
.from("advertisements")
.insert({

user_id:userData.user.id,

package_name:packageName,

amount:amount,

status:"pending_review",

created_at:new Date()

});


document.getElementById("message").innerHTML =
error
?"Advertisement request failed"
:"Advertisement request submitted for review";

}


window.requestAd=requestAd;
