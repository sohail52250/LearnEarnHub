
const router=require("express").Router();

const db=require("../database");


router.post("/add",async(req,res)=>{


const {data,error}=await db
.from("reviews")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data);

});



router.get("/:id",async(req,res)=>{


const {data,error}=await db
.from("reviews")
.select("*")
.eq("user_id",req.params.id);


res.json(data);

});


module.exports=router;

