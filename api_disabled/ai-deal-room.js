const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const deal_id=req.query.deal_id;


const room=await db
.from("ai_deal_rooms")
.select("*")
.eq("deal_id",deal_id);


const checks=await db
.from("deal_due_diligence")
.select("*")
.eq("deal_id",deal_id);


const negotiations=await db
.from("deal_negotiations")
.select("*")
.eq("deal_id",deal_id);


return res.json({

success:true,

room:room.data||[],

due_diligence:checks.data||[],

negotiations:negotiations.data||[]

});


}



if(req.method==="POST"){


const {data,error}=await db

.from("ai_deal_rooms")

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
