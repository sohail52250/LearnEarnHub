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






// Course lessons API
router.get("/lessons/:course_id", async(req,res)=>{
    try {
        const courseId = Number(req.params.course_id);

        const {data,error}=await db
            .from("course_lessons")
            .select("*")
            .eq("course_id",courseId)
            .order("lesson_order",{ascending:true});

        if(error){
            console.log(error);
            return res.status(400).json(error);
        }

        res.json(data || []);

    } catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports=router;
