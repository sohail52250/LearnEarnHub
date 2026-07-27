const db=require("../database");

module.exports=async(req,res)=>{


const organization_id=req.query.organization_id;


const members=await db
.from("organization_members")
.select("*")
.eq("organization_id",organization_id);


const rooms=await db
.from("enterprise_deal_rooms")
.select("*")
.eq("organization_id",organization_id);


const reports=await db
.from("enterprise_reports")
.select("*")
.eq("organization_id",organization_id);


res.json({

success:true,

members:members.data||[],

deal_rooms:rooms.data||[],

reports:reports.data||[]

});


};
