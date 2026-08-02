#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Lesson Player Setup ==="

mkdir -p public/js api services



cat > services/lesson-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getLesson(course_id,lesson_order){

const {data,error}=await db
.from("course_lessons")
.select("*")
.eq("course_id",course_id)
.eq("lesson_order",lesson_order)
.single();


if(error) throw error;


return data;

}



async function completeLesson(
user_id,
course_id,
lesson_id
){

const {data,error}=await db
.from("learning_progress")
.upsert({

user_id,

course_id,

lesson_id,

completed:true,

completed_at:new Date()

},{
onConflict:"user_id,lesson_id"
})
.select()
.single();


if(error) throw error;


return data;

}


module.exports={
getLesson,
completeLesson
};

JS



cat > api/lesson.js <<'JS'
const service=require("../services/lesson-service");


module.exports=async function(req,res){

try{


if(req.query.course_id){

return res.json(
await service.getLesson(
req.query.course_id,
req.query.lesson_order
)
);

}



if(req.body.action==="complete"){

return res.json(
await service.completeLesson(
req.body.user_id,
req.body.course_id,
req.body.lesson_id
)
);

}


res.status(400).json({
error:"Invalid request"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/lesson" server.js
then

cat >> server.js <<'JS'


// Lesson Player API

const lesson=require("./api/lesson");

app.get(
"/api/lesson",
lesson
);

app.post(
"/api/lesson",
lesson
);

JS

fi



cat > public/lesson.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Lesson</title>

<script src="/js/lesson.js"></script>


<style>

body{
font-family:Arial;
padding:20px;
background:#f5f7fb;
}

.box{
background:white;
padding:25px;
border-radius:12px;
}

button{
padding:12px;
background:#1565c0;
color:white;
border:0;
border-radius:8px;
}

</style>


</head>


<body>


<div class="box">


<h1 id="title">
Loading...
</h1>


<div id="content"></div>


<button onclick="completeCurrentLesson()">
✅ Complete Lesson
</button>


</div>



<script>


let params=
new URLSearchParams(location.search);


let user_id=params.get("user_id");
let course_id=params.get("course_id");
let lesson_order=params.get("lesson_order");

let lesson;



async function loadLesson(){


let res=await fetch(
`/api/lesson?course_id=${course_id}&lesson_order=${lesson_order}`
);


lesson=await res.json();


title.innerText=
lesson.title_en;


content.innerText=
lesson.content_en;


}



async function completeCurrentLesson(){


await fetch("/api/lesson",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"complete",

user_id,

course_id,

lesson_id:lesson.id

})

});


alert("Lesson completed ✅");


}



loadLesson();


</script>


</body>

</html>
HTML



echo "✅ Lesson player created"

node -c server.js

echo "=== DONE ==="

