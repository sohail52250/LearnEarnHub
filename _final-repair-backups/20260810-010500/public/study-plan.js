async function loadStudyPlan(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);


const {data:userData}=await client.auth.getUser();


if(!userData.user) return;



const {data:progress}=await client
.from("lesson_progress")
.select("*")
.eq("user_id",userData.user.id);



const completed =
(progress || []).map(
p=>p.course_slug
);



const roadmap=[

{
slug:"computer-basics",
title:"Computer Basics"
},

{
slug:"internet-browsing",
title:"Internet Skills"
},

{
slug:"email-basics",
title:"Email Skills"
},

{
slug:"word-basics",
title:"Microsoft Word"
},

{
slug:"excel-basics",
title:"Microsoft Excel"
},

{
slug:"freelancing-basics",
title:"Freelancing Basics"
},

{
slug:"digital-marketing",
title:"Digital Marketing"
}

];



const box=document.getElementById(
"study-plan"
);


let html="";


roadmap.forEach(item=>{


const done =
completed.includes(item.slug);


html += `

<p>

${done ? "✅" : "🔒"}

${item.title}

</p>

`;

});



box.innerHTML=html;



const next =
roadmap.find(
r=>!completed.includes(r.slug)
);



document.getElementById(
"next-step"
).innerHTML = next ?

`

<h3>
➡ ${next.title}
</h3>

<p>
Complete this lesson to continue your earning journey.
</p>

<a href="/course-player.html?id=${next.slug}">

<button>
Start Learning
</button>

</a>

`

:

`

<h3>
🎉 Learning path completed
</h3>

<p>
Explore earning opportunities.
</p>

`;

}


document.addEventListener(
"DOMContentLoaded",
loadStudyPlan
);
