const express=require("express");
const router=express.Router();
const supabase=require("../database");


router.get("/admin/backups",async(req,res)=>{

const {data,error}=await supabase
.from("system_backups")
.select("*")
.order("created_at",{ascending:false});

if(error)
return res.status(500).json(error);

res.json(data);

});


router.post("/admin/create-backup",async(req,res)=>{

const backup={
name:req.body.name || "Manual Backup",
git_commit:"current",
deployment:"vercel",
status:"stable",
audit_result:"passed"
};

const {data,error}=await supabase
.from("system_backups")
.insert(backup)
.select();

if(error)
return res.status(500).json(error);

res.json({
success:true,
data:data
});

});


module.exports=router;
