const db=require("../database");

module.exports=async(req,res)=>{

const instructor_id=req.query.instructor_id;


const {data,error}=await db
.from("instructor_courses")
.select(`
id,
status,
course_id,
courses(*)
`)
.eq("instructor_id",instructor_id);


return res.json({
success:!error,
data,
error
});

};
