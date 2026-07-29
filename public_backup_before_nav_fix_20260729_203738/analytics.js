
async function loadAnalytics(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


let box=document.getElementById(
"analytics-box"
);



const students=await client
.from("profiles")
.select("*",{count:"exact",head:true});


const courses=await client
.from("courses")
.select("*",{count:"exact",head:true});


const lessons=await client
.from("lesson_progress")
.select("*",{count:"exact",head:true});


const certificates=await client
.from("certificates")
.select("*",{count:"exact",head:true});



box.innerHTML=

`

<h3>👥 Students:
${students.count || 0}</h3>

<h3>📚 Courses:
${courses.count || 0}</h3>

<h3>✅ Completed Lessons:
${lessons.count || 0}</h3>

<h3>🎓 Certificates:
${certificates.count || 0}</h3>

`;

}


document.addEventListener(
"DOMContentLoaded",
loadAnalytics
);

