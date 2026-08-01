const router=require("express").Router();
const db=require("./database");

router.get("/api/debug-lessons", async(req,res)=>{
    const {data,error}=await db
        .from("course_lessons")
        .select("id,course_id,title_en")
        .limit(5);

    res.json({
        error,
        count:data ? data.length : 0,
        sample:data
    });
});

module.exports=router;
