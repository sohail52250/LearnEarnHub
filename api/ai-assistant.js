const db=require("../database");

module.exports=async(req,res)=>{

const {
user_id,
message
}=req.body;


const response =
"LearnEarnHub AI Assistant: Continue learning and complete courses to improve your skills.";


const {data,error}=await db
.from("ai_assistant_messages")
.insert([{
user_id,
message,
response
}])
.select();


return res.json({
success:!error,
response,
data,
error
});

};
