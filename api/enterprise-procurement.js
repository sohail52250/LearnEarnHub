const db=require("../database");

module.exports=async(req,res)=>{


const organization_id=req.query.organization_id;


const vendors=await db
.from("vendor_profiles")
.select("*")
.order("created_at",{ascending:false});


const requests=await db
.from("purchase_requests")
.select("*")
.eq("organization_id",organization_id);


const contracts=await db
.from("enterprise_contract_workflow")
.select("*")
.eq("organization_id",organization_id);


res.json({

success:true,

vendors:vendors.data||[],

purchase_requests:requests.data||[],

contracts:contracts.data||[]

});


};
