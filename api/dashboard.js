const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

module.exports = async (req,res)=>{

try{

const {user_id}=req.query;

if(!user_id){
 return res.json({
  success:false,
  error:"Missing user_id"
 });
}


const {data:user,userError}=await supabase
.from("users")
.select("id,name,email,language,points,created_at")
.eq("id",user_id)
.single();


if(userError){
 return res.json({
  success:false,
  step:"users",
  error:userError
 });
}


const {data:progress, error:progressError}=await supabase
.from("user_progress")
.select("course_id,completed,points_added,created_at")
.eq("user_id",user_id);


if(progressError){
 return res.json({
  success:false,
  step:"progress",
  error:progressError
 });
}


let totalPoints = 0;

(progress || []).forEach(item=>{
 totalPoints += item.points_added || 0;
});


res.json({
 success:true,
 user:{
  ...user,
  earned_points:totalPoints
 },
 completed_courses:progress || []
});


}catch(e){

res.status(500).json({
 success:false,
 step:"crash",
 error:e.message,
 stack:e.stack
});

}

};
