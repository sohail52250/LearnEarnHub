#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Course Progress System Setup ==="


mkdir -p api services



cat > services/course-progress-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function enrollCourse(user_id,course_id){

const {data,error}=await db
.from("course_enrollments")
.upsert({

user_id,

course_id

})
.select()
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

},
{
onConflict:"user_id,lesson_id"
})
.select()
.single();


if(error) throw error;

return data;

}




async function getProgress(
user_id,
course_id
){


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

course_id,

total_lessons:total||0,

completed_lessons:done||0,

percentage:
total?
Math.round((done/total)*100)
:0

};


}


module.exports={
enrollCourse,
completeLesson,
getProgress
};

JS




cat > api/course-progress.js <<'JS'
const service=require("../services/course-progress-service");


module.exports=async function(req,res){

try{


const action=req.body.action;


if(action==="enroll"){

return res.json(
await service.enrollCourse(
req.body.user_id,
req.body.course_id
));

}



if(action==="complete"){

return res.json(
await service.completeLesson(
req.body.user_id,
req.body.course_id,
req.body.lesson_id
));

}



if(action==="progress"){

return res.json(
await service.getProgress(
req.body.user_id,
req.body.course_id
));

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




if ! grep -q "course-progress" server.js
then

cat >> server.js <<'JS'


// Course Progress API

const courseProgress=require("./api/course-progress");

app.post(
"/api/course-progress",
courseProgress
);

JS

fi



node -c server.js


echo ""
echo "✅ Course Progress API created"

echo ""
echo "Available actions:"
echo "enroll"
echo "complete"
echo "progress"

