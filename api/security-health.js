const db=require("../database");


module.exports=async(req,res)=>{


const logs=await db

.from("api_access_logs")

.select("*")

.order("created_at",{ascending:false})

.limit(20);



res.json({

success:true,

security_status:"active",

recent_logs:logs.data||[]

});


};
