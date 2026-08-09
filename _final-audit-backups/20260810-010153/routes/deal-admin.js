const express=require("express");
const router=express.Router();

function adminOnly(req,res,next){
 if(req.user && req.user.role==="admin"){
   next();
 }else{
   res.status(403).json({error:"Admin access required"});
 }
}

router.get("/admin/deals/:type",adminOnly,async(req,res)=>{
 res.json({
   message:"Admin can view deal requests",
   type:req.params.type
 });
});

router.post("/admin/deals/grant-access",adminOnly,async(req,res)=>{
 res.json({
   success:true,
   message:"Access granted to requester"
 });
});

module.exports=router;
