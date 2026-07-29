
async function enrollCourse(courseId){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:user}=await client.auth.getUser();


if(!user.user){

alert("Please login first");

return;

}


const {error}=await client
.from("enrollments")
.insert({

user_id:user.user.id,

course_id:courseId,

status:"active"

});


if(error){

alert(error.message);

return;

}


alert("Course added to My Courses!");

window.location="/my-courses.html";


}

