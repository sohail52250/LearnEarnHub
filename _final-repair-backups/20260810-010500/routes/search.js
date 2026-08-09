const router=require("express").Router();
const db=require("../database");


router.get("/",async(req,res)=>{

let q=req.query.q || "";


const {data,error}=await db
.from("ads")
.select("*")
.or(
`title_en.ilike.%${q}%,city.ilike.%${q}%`
);


if(error)
return res.status(400).json(error);


res.json(data);

});


module.exports=router;
