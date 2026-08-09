
async function loadMarketplace(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data,error}=await client

.from("courses")

.select("*")

.eq("status","approved");



const box=document.getElementById(
"courses"
);



if(error){

box.innerHTML="Unable to load courses";

return;

}



box.innerHTML=(data||[]).map(c=>`

<div class="card">


<h2>
${c.title || "Skill Course"}
</h2>


<p>
${c.description || ""}
</p>


<p>
Category:
${c.category || "General"}
</p>


<button onclick="enrollCourse('${c.id}')">

🎓 Enroll

</button>


</div>


`).join("");

}



async function enrollCourse(courseId){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:{user}} =
await client.auth.getUser();



if(!user){

location.href="/login.html";

return;

}



await client

.from("course_enrollments")

.insert({

course_id:courseId,

learner_id:user.id

});



alert(
"Course enrolled"
);


}



document.addEventListener(
"DOMContentLoaded",
loadMarketplace
);

