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

