const router=require("express").Router();
const db=require("./database");

router.get("/", async(req,res)=>{
  try{
    const {data,error}=await db
      .from("course_lessons")
      .select("id,course_id,title_en")
      .limit(5);

    res.json({
      success:true,
      error:error,
      count:data ? data.length : 0,
      sample:data
    });

  }catch(e){
    res.status(500).json({
      success:false,
      message:e.message
    });
  }
});

module.exports=router;
