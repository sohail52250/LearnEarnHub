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

const {data:user,error:userError}=await supabase
.from("users")
.select("id,name,email,points,language,created_at")
.eq("id",user_id)
.single();

if(userError){
 return res.json({
  success:false,
  step:"user",
  error:userError
 });
}


const {data:progress,error:progressError}=await supabase
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


res.json({
 success:true,
 user:user,
 completed_courses:progress
});


}catch(e){

res.status(500).json({
 success:false,
 error:e.message
});

}

};
