const db=require("../database");

module.exports=async(req,res)=>{

const {
course_id,
review_text,
rating
}=req.body;


const {data,error}=await db
.from("ai_course_reviews")
.insert([{
course_id,
review_text,
rating
}])
.select();


return res.json({
success:!error,
data,
error
});

};
