require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

async function completeLesson(user_id,course_id,lesson_id){

const {error}=await db
.from("learning_progress")
.insert({
user_id,
course_id,
lesson_id,
completed:true,
completed_at:new Date()
});

if(error){
console.log("❌",error.message);
return;
}

console.log("✅ Lesson completed");

}

module.exports={completeLesson};
