
const router=require("express").Router();

const db=require("../database");


router.post("/create",async(req,res)=>{


const {data,error}=await db
.from("profiles")
.insert([req.body])
.select();


if(error)
return res.status(400).json(error);


res.json(data);

});



router.get("/:id",async(req,res)=>{


const {data,error}=await db
.from("profiles")
.select("*")
.eq("user_id",req.params.id);


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;

