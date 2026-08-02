
const express=require("express");

const router=express.Router();

const auth=require("../../middleware/api-key-auth");


router.get(
"/",
auth,
async(req,res)=>{


const {createClient}=require("@supabase/supabase-js");


const db=createClient(

process.env.SUPABASE_URL,

process.env.SUPABASE_SERVICE_KEY

);



const {data}=await db

.from("imported_jobs")

.select("*")

.eq("status","active")

.limit(100);



res.json({

partner:req.partner.name,

count:data.length,

jobs:data

});


});


module.exports=router;

