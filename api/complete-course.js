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
 return res.json({
  success:false,
  error:"Missing user_id or course_id"
 });
}

const {data:course,error:courseError} =
await supabase
.from("courses")
.select("points")
.eq("id",course_id)
.single();

if(courseError){
 return res.json({
  step:"course",
  error:courseError
 });
}


const {data:progress,error:progressError} =
await supabase
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
  step:"progress",
  error:progressError
 });
}


return res.json({
 success:true,
 message:"Course completed",
 points:course.points || 0,
 data:progress
});


}catch(e){

return res.status(500).json({
 success:false,
 step:"server",
 error:e.message
});

}

};
