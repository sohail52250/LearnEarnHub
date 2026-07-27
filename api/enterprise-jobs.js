const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const enterprise_id=req.query.enterprise_id;


const {data,error}=await db

.from("enterprise_jobs")

.select("*")

.eq("enterprise_id",enterprise_id);



return res.json({

success:true,

jobs:data||[],

error

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("enterprise_jobs")

.insert([req.body])

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
