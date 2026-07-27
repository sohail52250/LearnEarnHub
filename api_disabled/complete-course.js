const { createClient } = require("@supabase/supabase-js");

const db = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

module.exports = async (req,res)=>{

try{

if(req.method !== "POST"){
 return res.status(405).json({error:"POST only"});
}

const {user_id,course_id}=req.body;

if(!user_id || !course_id){
 return res.json({
  success:false,
  error:"Missing user_id or course_id"
 });
}


// check already completed

const {data:old}=await db
.from("user_progress")
.select("id")
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true)
.maybeSingle();


if(old){

 return res.json({
  success:false,
  message:"Course already completed"
 });

}


// get course points

const {data:course,error:courseError}=await db
.from("courses")
.select("points")
.eq("id",course_id)
.single();


if(courseError){
 return res.json({
  success:false,
  error:courseError
 });
}


// save progress

const {data:progress,error:progressError}=await db
.from("user_progress")
.insert({
 user_id,
 course_id,
 completed:true,
 points_added:course.points || 0
})
.select();


if(progressError){
 return res.json({
  success:false,
  error:progressError
 });
}


// update user points

const {data:user}=await db
.from("users")
.select("points")
.eq("id",user_id)
.single();


await db
.from("users")
.update({
 points:(user.points || 0)+(course.points || 0)
})
.eq("id",user_id);


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

};
