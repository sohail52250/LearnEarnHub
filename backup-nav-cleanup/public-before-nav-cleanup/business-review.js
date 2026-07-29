
async function submitReview(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const user=JSON.parse(
localStorage.getItem("user") || "null"
);


if(!user){

alert("Login required");
return;

}


const {error}=await client
.from("business_reviews")
.insert({

business_id:
document.getElementById("business_id").value,

reviewer_id:user.id,

rating:
Number(document.getElementById("rating").value),

comment:
document.getElementById("review").value,

verified:true,

created_at:new Date()

});


document.getElementById("message").innerHTML =
error
?
"Review failed"
:
"✅ Review submitted";


}


window.submitReview=submitReview;

