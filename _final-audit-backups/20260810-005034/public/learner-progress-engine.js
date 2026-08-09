
async function updateCourseProgress(
courseId,
progress
){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:{user}} =
await client.auth.getUser();



await client

.from("course_enrollments")

.update({

progress:progress,

status:
progress>=100
?
"completed"
:
"learning",

completed_at:
progress>=100
?
new Date()
:
null

})

.eq("course_id",courseId)

.eq("learner_id",user.id);


}

