const router=require("express").Router();
const db=require("../database");


router.post("/create",async(req,res)=>{

const {data,error}=await db
.from("courses")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data);

});


router.get("/",async(req,res)=>{

const {data,error}=await db
.from("courses")
.select("*");


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;
