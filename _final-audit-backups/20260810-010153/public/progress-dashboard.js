
async function loadCourseProgress(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const box=document.getElementById(
"course-progress"
);


if(!box)return;


const {data:userData}=await client.auth.getUser();


if(!userData.user){

box.innerHTML="Login to see progress";

return;

}


const {data}=await client

.from("lesson_progress")

.select("*")

.eq("user_id",userData.user.id);



let completed=data ? data.length : 0;


let total=16;


let percent=Math.round(
(completed/total)*100
);


box.innerHTML=`

<h3>Learning Progress</h3>

<p>
Completed Lessons:
${completed}/${total}
</p>


<div style="
width:100%;
background:#ddd;
border-radius:10px;
">

<div style="
width:${percent}%;
background:#4caf50;
padding:10px;
border-radius:10px;
color:white;
">

${percent}%

</div>

</div>


${percent>=100 ?
"<p>🎓 All courses completed! Certificate unlocked.</p>"
:
"<p>Keep learning!</p>"
}

`;

}


document.addEventListener(
"DOMContentLoaded",
loadCourseProgress
);

