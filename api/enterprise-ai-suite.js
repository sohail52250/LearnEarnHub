const db=require("../database");

module.exports=async(req,res)=>{


const organization_id=req.query.organization_id;


const reports=await db
.from("enterprise_ai_reports")
.select("*")
.eq("organization_id",organization_id);


const diligence=await db
.from("enterprise_due_diligence")
.select("*")
.eq("organization_id",organization_id);


const risks=await db
.from("enterprise_risk_scores")
.select("*")
.eq("organization_id",organization_id);


const metrics=await db
.from("executive_dashboard_metrics")
.select("*")
.eq("organization_id",organization_id);



res.json({

success:true,

ai_reports:reports.data||[],

due_diligence:diligence.data||[],

risk_scores:risks.data||[],

executive_metrics:metrics.data||[]

});


};
