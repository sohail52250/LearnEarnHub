const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="POST"){

const {data,error}=await db
.from("business_verification_requests")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

}


const {data,error}=await db
.from("business_verification_requests")
.select("*");


return res.json({
data,
error
});

};
