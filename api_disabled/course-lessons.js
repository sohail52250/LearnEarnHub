const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const course_id=req.query.course_id;

const {data,error}=await db
.from("course_lessons")
.select("*")
.eq("course_id",course_id)
.order("lesson_order");

return res.json({
data,
error
});

}


if(req.method==="POST"){

const lesson=req.body;

const {data,error}=await db
.from("course_lessons")
.insert([lesson])
.select();

return res.json({
success:!error,
data,
error
});

}


return res.status(405).json({
error:"Method not allowed"
});

};
