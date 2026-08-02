#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Next Lesson System Setup ==="

mkdir -p services api public/js



cat > services/next-lesson-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getNextLesson(course_id,lesson_order){


const {data,error}=await db
.from("course_lessons")
.select("*")
.eq("course_id",course_id)
.gt("lesson_order",lesson_order)
.order("lesson_order",{ascending:true})
.limit(1)
.single();



if(error) return null;


return data;

}




async function getPreviousLesson(course_id,lesson_order){


const {data,error}=await db
.from("course_lessons")
.select("*")
.eq("course_id",course_id)
.lt("lesson_order",lesson_order)
.order("lesson_order",{ascending:false})
.limit(1)
.single();



if(error) return null;


return data;

}




async function checkCompletion(user_id,course_id){


const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course_id);



const {count:done}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true);



return {

completed:
total && total===done,

percentage:
total?
Math.round((done/total)*100)
:0

};


}



module.exports={
getNextLesson,
getPreviousLesson,
checkCompletion
};

JS



cat > api/next-lesson.js <<'JS'
const service=require("../services/next-lesson-service");


module.exports=async function(req,res){

try{


if(req.query.action==="next"){

return res.json(
await service.getNextLesson(
req.query.course_id,
req.query.lesson_order
)
);

}



if(req.query.action==="previous"){

return res.json(
await service.getPreviousLesson(
req.query.course_id,
req.query.lesson_order
)
);

}



if(req.query.action==="completion"){

return res.json(
await service.checkCompletion(
req.query.user_id,
req.query.course_id
)
);

}



res.status(400).json({
error:"Invalid action"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/next-lesson" server.js
then

cat >> server.js <<'JS'


// Next Lesson API

const nextLesson=require("./api/next-lesson");

app.get(
"/api/next-lesson",
nextLesson
);

JS

fi



cat > public/js/next-lesson.js <<'JS'

async function openNext(){

let res=await fetch(
`/api/next-lesson?action=next&course_id=${course_id}&lesson_order=${lesson_order}`
);


let next=await res.json();


if(next){

location.href=
`/lesson.html?user_id=${user_id}&course_id=${course_id}&lesson_order=${next.lesson_order}`;

}else{

alert("🎉 Course lessons completed");

}

}



async function checkCourseComplete(){


let res=await fetch(
`/api/next-lesson?action=completion&user_id=${user_id}&course_id=${course_id}`
);


let data=await res.json();


if(data.completed){

alert("🏆 Course completed! Certificate ready");

}


}

JS



echo "✅ Next lesson system created"

node -c server.js

echo "=== DONE ==="

