const db=require("../database");

module.exports=async(req,res)=>{

const {task_id,user_id}=req.body;


const {data,error}=await db
.from("task_applications")
.insert([{
task_id,
user_id
}])
.select();


return res.json({
success:!error,
data,
error
});

};
