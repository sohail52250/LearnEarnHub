const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

module.exports = async (req,res)=>{

try {

if(req.method !== "POST"){
 return res.status(405).json({error:"POST only"});
}

const {user_id, course_id} = req.body;

if(!user_id || !course_id){
 return res.status(400).json({
  success:false,
  error:"Missing user_id or course_id"
 });
}


// Check existing completion
const {data:existing} = await supabase
.from("user_progress")
.select("id")
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true)
.maybeSingle();


if(existing){
 return res.json({
  success:false,
  message:"Course already completed"
 });
}


// Get course points
const {data:course,error:courseError} = await supabase
.from("courses")
.select("points")
.eq("id",course_id)
.single();


if(courseError){
 return res.json({
  success:false,
  step:"course",
  error:courseError
 });
}


// Save completion
const {data:progress,error:progressError} = await supabase
.from("user_progress")
.insert({
 user_id:user_id,
 course_id:course_id,
 completed:true,
 points_added:course.points || 0
})
.select();


if(progressError){
 return res.json({
  success:false,
  step:"progress",
  error:progressError
 });
}


// Update user points
const {data:userData}=await supabase
.from("users")
.select("points")
.eq("id",user_id)
.single();


await supabase
.from("users")
.update({
 points:(userData?.points || 0) + (course.points || 0)
})
.eq("id",user_id);


return res.json({
 success:true,
 message:"Course completed",
 points:course.points || 0,
 data:progress
});


}catch(e){

return res.status(500).json({
 success:false,
 error:e.message
});

}

};
