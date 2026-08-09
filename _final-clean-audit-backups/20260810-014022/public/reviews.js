
async function submitReview(courseId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user){

alert("Please login first");

return;

}


let rating=document.getElementById(
"rating-"+courseId
).value;


let comment=document.getElementById(
"comment-"+courseId
).value;


const {error}=await client
.from("reviews")
.insert({

user_id:userData.user.id,

course_id:courseId,

rating:rating,

comment:comment

});


if(error){

alert(error.message);

return;

}


alert("Review submitted!");

}

