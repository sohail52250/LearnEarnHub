const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

module.exports = async (req,res)=>{

if(req.method !== "POST"){
 return res.status(405).json({error:"POST only"});
}

const {user_id, course_id} = req.body;

const {data:course,error:courseError} =
await supabase
.from("courses")
.select("points")
.eq("id",course_id)
.single();

if(courseError)
 return res.json({success:false,error:courseError});


const {data:progress,error:progressError} =
await supabase
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


await supabase.rpc("increment_points",{
 userid:user_id,
 amount:course.points
});


res.json({
success:true,
message:"Course completed",
points:course.points,
data:progress
});

};
