const db=require("../database");

module.exports=async(req,res)=>{


const organization_id=req.query.organization_id;


const insights=await db
.from("erp_ai_insights")
.select("*")
.eq("organization_id",organization_id);


const predictions=await db
.from("inventory_predictions")
.select("*")
.eq("organization_id",organization_id);


const risks=await db
.from("supplier_risk_alerts")
.select("*")
.eq("organization_id",organization_id);


const reports=await db
.from("executive_ai_reports")
.select("*")
.eq("organization_id",organization_id);



res.json({

success:true,

ai_insights:insights.data||[],

inventory_predictions:predictions.data||[],

supplier_risk_alerts:risks.data||[],

executive_reports:reports.data||[]

});


};
