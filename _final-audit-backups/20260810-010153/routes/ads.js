const express=require("express");
const db=require("../database");

const router=express.Router();


router.post("/create",async(req,res)=>{

const {data,error}=await db
.from("ads")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data[0]);

});


router.get("/",async(req,res)=>{

const {data,error}=await db
.from("ads")
.select("*")
.eq("approved",true);


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;
