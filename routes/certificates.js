const express=require("express");
const router=express.Router();

const {checkCourseCompletion}=require("../services/certificate-service");


router.get("/:user_id/:course_id",async(req,res)=>{

 const result=await checkCourseCompletion(
   req.params.user_id,
   req.params.course_id
 );

 res.json(result);

});


module.exports=router;
