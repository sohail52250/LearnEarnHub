const db=require("../database");

module.exports=async(req,res)=>{

const organization_id=req.query.organization_id;


const hr=await db
.from("enterprise_hr_employees")
.select("*")
.eq("organization_id",organization_id);


const accounts=await db
.from("enterprise_accounting")
.select("*")
.eq("organization_id",organization_id);


const projects=await db
.from("enterprise_projects")
.select("*")
.eq("organization_id",organization_id);


const documents=await db
.from("enterprise_documents")
.select("*")
.eq("organization_id",organization_id);


const security=await db
.from("enterprise_security_events")
.select("*")
.eq("organization_id",organization_id);



res.json({

success:true,

dashboard:{

employees:(hr.data||[]).length,

projects:(projects.data||[]).length,

documents:(documents.data||[]).length,

security_events:(security.data||[]).length

},

hr:hr.data||[],

accounting:accounts.data||[],

projects:projects.data||[],

documents:documents.data||[],

security:security.data||[]

});


};
