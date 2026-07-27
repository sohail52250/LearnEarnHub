const db=require("../database");

module.exports=async(req,res)=>{

if(req.method!=="POST"){
return res.status(405).json({
error:"POST only"
});
}


const {
course_id,
admin_id,
status,
review_notes
}=req.body;


const {data,error}=await db
.from("course_reviews")
.insert([{
course_id,
admin_id,
status,
review_notes
}])
.select();


return res.json({
success:!error,
data,
error
});

};
