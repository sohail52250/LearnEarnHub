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

