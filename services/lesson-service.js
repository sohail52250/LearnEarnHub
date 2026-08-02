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

