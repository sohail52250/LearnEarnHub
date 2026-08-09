const express=require("express");
const router=express.Router();

const {getDashboard}=require("../services/dashboard-service");


router.get("/:user_id",async(req,res)=>{

 try{

 const data=await getDashboard(req.params.user_id);

 res.json(data);

 }catch(error){

 res.status(500).json({
  error:error.message
 });

 }

});


module.exports=router;
