const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="POST"){


const {data,error}=await db

.from("investment_interests")

.insert([req.body])

.select();



return res.json({

success:!error,

data,

error

});


}


};
