const express = require("express");
const router = express.Router();

const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

router.post("/", async (req,res)=>{

try {

const {user_id,course_id}=req.body;

const {data:course,error:courseError}=await supabase
.from("courses")
.select("points")
.eq("id",course_id)
.single();

if(courseError)
 return res.json({success:false,error:courseError});


const {data:progress,error:progressError}=await supabase
.from("course_progress")
.insert({
 user_id,
 course_id,
 completed:true,
 points_added:course.points
})
.select();

if(progressError)
 return res.json({success:false,error:progressError});


const {error:updateError}=await supabase
.rpc("increment_points",{
 userid:user_id,
 amount:course.points
});


if(updateError)
 return res.json({success:false,error:updateError});


res.json({
success:true,
message:"Course completed",
points:course.points,
data:progress
});


}catch(e){

res.status(500).json({
success:false,
error:e.message
});

}

});

module.exports=router;
