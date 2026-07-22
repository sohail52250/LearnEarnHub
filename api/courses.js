const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("courses")
.select("*");

res.json({
data,
error
});

};
