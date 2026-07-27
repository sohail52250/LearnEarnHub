const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){
const user_id=req.query.user_id;

const {data,error}=await db
.from("notifications")
.select("*")
.eq("user_id",user_id)
.order("created_at",{ascending:false});

return res.json({success:true,data,error});
}

res.status(405).json({error:"Method not allowed"});
};
