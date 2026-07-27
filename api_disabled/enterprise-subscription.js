const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const subscriptions=await db

.from("enterprise_subscriptions")

.select("*")

.eq("enterprise_id",enterprise_id);



return res.json({

success:true,

subscriptions:subscriptions.data || []

});


}



if(req.method==="POST"){


const {

enterprise_id,

plan_id

}=req.body;


const {data,error}=await db

.from("enterprise_subscriptions")

.insert([{

enterprise_id,

plan_id,

status:"active"

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
