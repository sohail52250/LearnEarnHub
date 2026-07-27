const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const {data,error}=await db

.from("business_deals")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

deals:data||[],

error

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("business_deals")

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
