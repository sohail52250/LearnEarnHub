
async function updateCourseStatus(id,status){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:{user}} =
await client.auth.getUser();



await client

.from("course_submissions")

.update({

status:status,

approved_by:
status==="approved"
?
user.id
:
null,

approved_at:
status==="approved"
?
new Date()
:
null

})

.eq("id",id);



await client

.from("course_publish_logs")

.insert({

course_id:id,

action:status,

performed_by:user.id

});



alert(
"Course status updated"
);


location.reload();


}

