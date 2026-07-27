const db=require("../database");

module.exports=async(req,res)=>{

const {admin_id,action,details}=req.body;


const {data,error}=await db
.from("admin_logs")
.insert([{
admin_id,
action,
details
}])
.select();


return res.json({
success:!error,
data,
error
});

};
