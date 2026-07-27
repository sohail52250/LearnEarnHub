const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("platform_analytics")
.select("*")
.order("created_at",{ascending:false});


return res.json({
data,
error
});

};
