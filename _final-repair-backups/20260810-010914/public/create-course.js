async function createCourse(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:{user}}=
await client.auth.getUser();


if(!user){
alert("Login required");
return;
}


const {error}=await client

.from("instructor_courses")

.insert({

instructor_id:user.id,

title:
document.getElementById("title").value,

description:
document.getElementById("description").value,

category:
document.getElementById("category").value,

level:
document.getElementById("level").value,

status:"pending_review"

});


if(error){

alert(error.message);

return;

}


alert("Course submitted for admin review");

location.href="/instructor-dashboard.html";


}
