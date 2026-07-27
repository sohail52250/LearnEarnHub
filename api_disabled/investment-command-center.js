const db=require("../database");

module.exports=async(req,res)=>{

const investor_id=req.query.investor_id;


const investments=await db
.from("investments")
.select("*")
.eq("investor_id",investor_id);


const pipeline=await db
.from("deal_pipeline")
.select("*")
.eq("investor_id",investor_id);


const alerts=await db
.from("intelligence_notifications")
.select("*")
.eq("investor_id",investor_id);


const compliance=await db
.from("investor_verification")
.select("*")
.eq("investor_id",investor_id);



res.json({

success:true,

summary:{

investments:
(investments.data||[]).length,

active_deals:
(pipeline.data||[]).length,

compliance_status:
compliance.data||[]

},

portfolio:
investments.data||[],

pipeline:
pipeline.data||[],

alerts:
alerts.data||[]

});


};
