const db=require("../database");

module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const {data,error}=await db
.from("ai_recommendations")
.select(`
id,
course_id,
reason,
score,
courses(*)
`)
.eq("user_id",user_id)
.order("score",{ascending:false});


return res.json({
data,
error
});

};
