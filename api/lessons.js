const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const {course_id}=req.query;

let query=db
.from("course_lessons")
.select("*")
.order("lesson_order");

if(course_id){
query=query.eq("course_id",course_id);
}

const {data,error}=await query;

return res.json({
data,
error
});

}


if(req.method==="POST"){

const {
course_id,
title_en,
title_ur,
content_en,
content_ur,
lesson_order,
points
}=req.body;


const {data,error}=await db
.from("course_lessons")
.insert([{
course_id,
title_en,
title_ur,
content_en,
content_ur,
lesson_order,
points
}])
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
