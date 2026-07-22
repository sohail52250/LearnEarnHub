const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("ads")
.select("*")
.order("created_at",{ascending:false});

res.json({
data,
error
});

};
