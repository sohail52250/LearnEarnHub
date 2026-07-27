const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const rounds=await db
.from("funding_rounds")
.select("*")
.order("created_at",{ascending:false});


return res.json({

success:true,

rounds:rounds.data||[]

});

}



if(req.method==="POST"){


const {data,error}=await db

.from("investment_offers")

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
