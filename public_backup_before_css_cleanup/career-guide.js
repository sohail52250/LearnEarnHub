const CAREERS = {

"digital-marketing":{

name:"Digital Marketer",

skills:[
"Digital Marketing",
"SEO",
"Social Media",
"Content Writing"
],

courses:[
"digital-marketing.html",
"google-search.html"
]

},


"freelancer":{

name:"Freelancer",

skills:[
"Communication",
"Online Safety",
"Portfolio Building",
"Freelancing"
],

courses:[
"freelancing-basics.html",
"online-safety.html"
]

},


"web-developer":{

name:"Web Developer",

skills:[
"HTML",
"CSS",
"JavaScript"
],

courses:[
"html-basics.html",
"css-basics.html"
]

},


"office-professional":{

name:"Office Professional",

skills:[
"Word",
"Excel",
"PowerPoint"
],

courses:[
"word-basics.html",
"excel-basics.html",
"powerpoint-basics.html"
]

}

};



async function analyzeCareer(){


const goal =
document.getElementById(
"career-goal"
).value;



const career =
CAREERS[goal];



const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const {data:userData}=await client.auth.getUser();


let completed=[];


if(userData.user){


const {data}=await client
.from("lesson_progress")
.select("course")
.eq(
"user_id",
userData.user.id
);


completed =
(data || [])
.map(x=>x.course);

}



const missing =
career.skills;



document.getElementById(
"career-result"
).innerHTML=

`

<h3>
${career.name}
</h3>


<h4>
Missing Skills:
</h4>


<ul>

${missing.map(s=>
`<li>${s}</li>`
).join("")}

</ul>



<h4>
Recommended Learning:
</h4>


<ul>

${career.courses.map(c=>

`
<li>
<a href="/course-player.html?id=${c}">
Start Course
</a>
</li>
`

).join("")}

</ul>


<p>
Complete skills → Build profile → Apply for opportunities.
</p>

`;

}


window.analyzeCareer=
analyzeCareer;
