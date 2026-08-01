const router=require("express").Router();
const db=require("./database");

router.get("/", async(req,res)=>{
 try{

  const all = await db
   .from("course_lessons")
   .select("id,course_id,title_en")
   .limit(5);

  const one = await db
   .from("course_lessons")
   .select("id,course_id,title_en")
   .eq("course_id",1);

  res.json({
   all_count: all.data ? all.data.length : 0,
   all_error: all.error,
   course1_count: one.data ? one.data.length : 0,
   course1_error: one.error,
   sample: one.data
  });

 }catch(e){
  res.status(500).json({
   message:e.message
  });
 }
});

module.exports=router;
