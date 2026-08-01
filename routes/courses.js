const router=require("express").Router();
const db=require("../database");


router.post("/create",async(req,res)=>{

const {data,error}=await db
.from("courses")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data);

});


router.get("/",async(req,res)=>{

const {data,error}=await db
.from("courses")
.select("*");


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;


// Course lessons API
router.get("/lessons/:course_id", async(req,res)=>{

    const courseId = req.params.course_id;

    const {data,error}=await db
        .from("course_lessons")
        .select("*")
        .eq("course_id", courseId)
        .order("lesson_order",{ascending:true});

    if(error){
        return res.status(400).json(error);
    }

    res.json(data);

});

