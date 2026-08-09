require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createLesson(lesson){

const {data,error}=await db
.from("course_lessons")
.insert(lesson)
.select()
.single();

if(error) throw error;

return data;

}



async function updateLesson(id,lesson){

const {data,error}=await db
.from("course_lessons")
.update(lesson)
.eq("id",id)
.select()
.single();

if(error) throw error;

return data;

}



async function deleteLesson(id){

const {error}=await db
.from("course_lessons")
.delete()
.eq("id",id);


if(error) throw error;


return {
success:true
};

}



async function listLessons(course_id){

const {data,error}=await db
.from("course_lessons")
.select("*")
.eq("course_id",course_id)
.order("lesson_order");


if(error) throw error;


return data;

}



module.exports={
createLesson,
updateLesson,
deleteLesson,
listLessons
};

