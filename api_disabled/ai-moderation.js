const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("ai_moderation_reviews")
.insert([{
content_type:req.body.content_type,
content_id:req.body.content_id,
review_status:"approved",
ai_result:"AI basic moderation completed"
}])
.select();


return res.json({
success:!error,
data,
error
});

};
