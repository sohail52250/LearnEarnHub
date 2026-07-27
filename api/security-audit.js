const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="POST"){


const {

user_id,

action,

details

}=req.body;


const {data,error}=await db

.from("security_audit_logs")

.insert([{

user_id,

action,

details

}])

.select();


return res.json({

success:!error,

data,

error

});


}


if(req.method==="GET"){


const {data,error}=await db

.from("security_audit_logs")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

data,

error

});


}


res.status(405).json({

error:"Method not allowed"

});


};
