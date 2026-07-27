const db=require("../database");

module.exports=async(req,res)=>{

const {
business_id,
learner_id,
match_score,
reason
}=req.body;


const {data,error}=await db
.from("ai_matches")
.insert([{
business_id,
learner_id,
match_score,
reason
}])
.select();


return res.json({
success:!error,
data,
error
});

};
