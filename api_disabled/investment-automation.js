const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const investor_id=req.query.investor_id;


const alerts=await db
.from("investor_alerts")
.select("*")
.eq("investor_id",investor_id)
.order("created_at",{ascending:false});


const reports=await db
.from("scheduled_reports")
.select("*")
.eq("investor_id",investor_id);


return res.json({

success:true,

alerts:alerts.data||[],

reports:reports.data||[]

});

}



if(req.method==="POST"){


const {data,error}=await db

.from("investor_alerts")

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
