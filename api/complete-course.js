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

const {user_id, course_id}=req.body;

const {data:course,error:courseError}=await db
.from("courses")
.select("points")
.eq("id",course_id)
.single();

if(courseError){
 return res.json({step:"course",error:courseError});
}

const {data:progress,error:progressError}=await db
.from("user_progress")
.insert({
 user_id:user_id,
 course_id:course_id,
 completed:true
})
.select();

if(progressError){
 return res.json({step:"progress",error:progressError});
}

res.json({
 success:true,
 message:"Course completed",
 points:course.points,
 data:progress
});

}catch(e){

res.status(500).json({
error:e.message
});

}

};
