const express = require("express");
const router = express.Router();

const { createClient } = require("@supabase/supabase-js");

const db = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

// Get course progress
router.get("/:user_id/:course_id", async (req,res)=>{

  const {user_id,course_id}=req.params;

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

  res.json({
    course_id,
    total_lessons:total||0,
    completed_lessons:completed||0,
    percentage: total ? Math.round((completed/total)*100):0
  });

});


// Mark lesson complete
router.post("/complete", async(req,res)=>{

 const {user_id,course_id,lesson_id}=req.body;

 const {data,error}=await db
 .from("learning_progress")
 .upsert({
   user_id,
   course_id,
   lesson_id,
   completed:true,
   completed_at:new Date()
 });

 if(error) return res.status(400).json(error);

 res.json({
   message:"Lesson completed ✅",
   data
 });

});


module.exports=router;
