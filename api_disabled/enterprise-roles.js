const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const {data,error}=await db

.from("enterprise_roles")

.select("*")

.eq("enterprise_id",enterprise_id);


return res.json({

success:true,

roles:data||[],

error

});


}



if(req.method==="POST"){


const {

enterprise_id,

user_id,

role,

permissions

}=req.body;


const {data,error}=await db

.from("enterprise_roles")

.upsert([{

enterprise_id,

user_id,

role,

permissions

}])

.select();


return res.json({

success:!error,

data,

error

});


}


res.status(405).json({

error:"Method not allowed"

});


};
