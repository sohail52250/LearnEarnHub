const router=require("express").Router();
const db=require("../database");


router.get("/ads",async(req,res)=>{

const {data,error}=await db
.from("ads")
.select("*")
.eq("approved",false);


if(error)
return res.status(400).json(error);

res.json(data);

});


router.post("/approve/:id",async(req,res)=>{

const {error}=await db
.from("ads")
.update({
approved:true
})
.eq("id",req.params.id);


if(error)
return res.status(400).json(error);


res.json({
message:"Approved"
});

});


module.exports=router;
