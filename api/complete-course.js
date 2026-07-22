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

console.log("INPUT:", user_id, course_id);

const {data:course,error:courseError} =
await supabase
.from("courses")
.select("points")
.eq("id",course_id)
.single();

if(courseError){
 return res.json({
  step:"course lookup",
  error:courseError
 });
}


const {data:progress,error:progressError} =
await supabase
.from("course_progress")
.insert({
 user_id:user_id,
 course_id:course_id,
 completed:true,
 points_added:course.points
})
.select();


if(progressError){
 return res.json({
  step:"progress insert",
  error:progressError
 });
}


const {error:updateError} =
await supabase
.rpc("increment_points",{
 userid:user_id,
 amount:course.points
});


if(updateError){
 return res.json({
  step:"points update",
  error:updateError
 });
}


return res.json({
 success:true,
 message:"Course completed",
 points:course.points,
 data:progress
});


}catch(e){

return res.status(500).json({
 step:"server crash",
 error:e.message
});

}

};
