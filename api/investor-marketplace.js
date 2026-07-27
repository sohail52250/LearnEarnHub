const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const requests=await db

.from("funding_requests")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

funding_requests:requests.data||[]

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("funding_requests")

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
