const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const course_id=req.query.course_id;

const {data,error}=await db
.from("quizzes")
.select("*")
.eq("course_id",course_id);

return res.json({
data,
error
});

}


if(req.method==="POST"){

const quiz=req.body;

const {data,error}=await db
.from("quiz_results")
.insert([quiz])
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
