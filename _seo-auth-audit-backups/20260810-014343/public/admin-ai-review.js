
async function reviewWithAI(courseId){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:course}=await client

.from("courses")

.select("*")

.eq("id",courseId)

.single();



if(!course){

alert("Course not found");

return;

}



const result =
await runAICourseReview(course);



await client

.from("ai_course_reviews")

.insert({

course_id:courseId,

...result

});


alert(
"AI review completed"
);


}


