const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const users=await db
.from("users")
.select("id,name,email")
.limit(100);


const enterprises=await db
.from("enterprise")
.select("*")
.limit(100);


const approvals=await db
.from("approval_requests")
.select("*")
.order("created_at",{ascending:false});


return res.json({

success:true,

users:users.data||[],

enterprises:enterprises.data||[],

approvals:approvals.data||[]

});


}


res.status(405).json({

error:"Method not allowed"

});


};
