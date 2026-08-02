require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

async function getCourseProgress(user_id,course_id){

const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course_id);


const {count:completed}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true);


return {
course_id,
total_lessons: total || 0,
completed_lessons: completed || 0,
percentage: total ? Math.round((completed/total)*100) : 0
};

}

module.exports={getCourseProgress};
