const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="POST"){

const {
instructor_id,
course_id
}=req.body;


const {data,error}=await db
.from("instructor_courses")
.insert([{
instructor_id,
course_id,
status:"pending"
}])
.select();


return res.json({
success:!error,
data,
error
});

}


if(req.method==="GET"){

const instructor_id=req.query.instructor_id;


const {data,error}=await db
.from("instructor_courses")
.select("*")
.eq("instructor_id",instructor_id);


return res.json({
data,
error
});

}


return res.status(405).json({
error:"Method not allowed"
});

};
