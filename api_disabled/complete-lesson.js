const db=require("../database");

module.exports=async(req,res)=>{

if(req.method!=="POST"){
return res.status(405).json({
error:"POST only"
});
}


const {
user_id,
lesson_id,
score
}=req.body;


const {data,error}=await db
.from("lesson_progress")
.insert([{
user_id,
lesson_id,
completed:true,
score:score || 0
}])
.select();


return res.json({
success:!error,
data,
error
});

};
