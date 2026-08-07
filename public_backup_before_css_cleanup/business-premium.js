
async function buyPlan(plan,amount){

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
.from("business_subscriptions")
.insert({

user_id:userData.user.id,

plan:plan,

amount:amount,

status:"pending_payment",

created_at:new Date()

});


document.getElementById("message").innerHTML=

error
?
"Subscription request failed"
:
"Subscription request submitted";


}


window.buyPlan=buyPlan;

