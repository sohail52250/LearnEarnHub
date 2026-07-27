const { createClient } = require("@supabase/supabase-js");

const db = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

module.exports = async (req,res)=>{

try{

const {user_id}=req.query;

if(!user_id){
 return res.json({
  success:false,
  error:"missing user_id"
 });
}


// user data (no password)
const {data:user,error:userError}=await db
.from("users")
.select("id,name,email,language,points,created_at,phone")
.eq("id",user_id)
.single();


if(userError){
 return res.json({
  success:false,
  step:"user",
  error:userError
 });
}


// progress data
const {data:progress,error:progressError}=await db
.from("user_progress")
.select("id,user_id,lesson_id,course_id,completed,score,created_at,points_added")
.eq("user_id",user_id);


if(progressError){
 return res.json({
  success:false,
  step:"progress",
  error:progressError
 });
}


return res.json({
 success:true,
 user:user,
 progress:progress
});


}catch(e){

return res.status(500).json({
 success:false,
 error:e.message
});

}

};
