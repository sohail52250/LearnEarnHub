const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const job_id=req.query.job_id;


const {data,error}=await db

.from("enterprise_job_applications")

.select("*")

.eq("job_id",job_id);


return res.json({

success:true,

applications:data||[],

error

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("enterprise_job_applications")

.insert([req.body])

.select();



return res.json({

success:!error,

data,

error

});


}


};
