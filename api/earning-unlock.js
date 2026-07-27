const db=require("../database");

module.exports=async(req,res)=>{

const {user_id}=req.query;

if(!user_id){
return res.status(400).json({
error:"missing user_id"
});
}


const {data,error}=await db
.from("user_progress")
.select("*")
.eq("user_id",user_id)
.eq("completed",true);


const completed=data ? data.length : 0;


return res.json({

user_id,

completed_courses:completed,

earning_unlocked: completed >= 1,

message:
completed >= 1
?
"Learning complete. Earning features unlocked."
:
"Complete courses to unlock earning."

,error

});

};
