const db=require("../database");

module.exports=async(req,res)=>{

const business_id=req.query.business_id;


const {data,error}=await db
.from("business_profiles")
.select("*")
.eq("id",business_id)
.single();


return res.json({
success:!error,
business:data,
error
});

};
