const db=require("../database");

module.exports=async(req,res)=>{

const {
learner_id,
opportunity_id,
match_score
}=req.body;


const {data,error}=await db
.from("opportunity_matches")
.insert([{
learner_id,
opportunity_id,
match_score
}])
.select();


return res.json({
success:!error,
data,
error
});

};
