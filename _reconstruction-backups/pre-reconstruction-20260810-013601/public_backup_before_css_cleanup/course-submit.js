
async function submitCourse(courseId){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:{user}} =
await client.auth.getUser();



if(!user){

alert("Login required");

return;

}



await client

.from("course_submissions")

.insert({

course_id:courseId,

instructor_id:user.id,

status:"pending_review",

submitted_at:new Date()

});



alert(
"Course submitted for review"
);


}

