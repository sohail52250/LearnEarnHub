const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("security_logs")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

};
