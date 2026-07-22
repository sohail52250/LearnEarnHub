const express = require("express");
const router = express.Router();
const { createClient } = require("@supabase/supabase-js");

router.post("/", async (req,res)=>{

try {

const supabase = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

const {user_id,course_id}=req.body;

if(!user_id || !course_id){
 return res.json({
  step:"input",
  error:"missing user_id or course_id"
 });
}

const courseResult = await supabase
.from("courses")
.select("*")
.eq("id",course_id)
.single();

if(courseResult.error){
 return res.json({
  step:"course",
  error:courseResult.error
 });
}


const progressResult = await supabase
.from("user_progress")
.insert({
 user_id:user_id,
 course_id:course_id,
 completed:true,
 points_added:courseResult.data.points || 0
})
.select();


if(progressResult.error){
 return res.json({
  step:"progress",
  error:progressResult.error
 });
}


return res.json({
 success:true,
 course:courseResult.data,
 progress:progressResult.data
});


}catch(err){

return res.status(500).json({
 step:"catch",
 error:err.message,
 stack:err.stack
});

}

});


module.exports = router;
