const db=require("../database");

module.exports=async(req,res)=>{


const organization_id=req.query.organization_id;


const finance=await db
.from("enterprise_finance_metrics")
.select("*")
.eq("organization_id",organization_id);


const inventory=await db
.from("enterprise_inventory")
.select("*")
.eq("organization_id",organization_id);


const suppliers=await db
.from("supplier_performance")
.select("*")
.eq("organization_id",organization_id);


const analytics=await db
.from("procurement_analytics")
.select("*")
.eq("organization_id",organization_id);



res.json({

success:true,

finance:finance.data||[],

inventory:inventory.data||[],

supplier_performance:suppliers.data||[],

procurement_analytics:analytics.data||[]

});


};
