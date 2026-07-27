const db=require("../database");

module.exports=async(req,res)=>{

const organization_id=req.query.organization_id;


const employees=await db
.from("enterprise_employees")
.select("*")
.eq("organization_id",organization_id);


const workflows=await db
.from("workflow_automation")
.select("*")
.eq("organization_id",organization_id);


const customers=await db
.from("crm_customers")
.select("*")
.eq("organization_id",organization_id);


const analytics=await db
.from("customer_analytics")
.select("*")
.eq("organization_id",organization_id);


const intelligence=await db
.from("business_process_intelligence")
.select("*")
.eq("organization_id",organization_id);



res.json({

success:true,

employees:employees.data||[],

workflows:workflows.data||[],

customers:customers.data||[],

customer_analytics:analytics.data||[],

process_intelligence:intelligence.data||[]

});


};
