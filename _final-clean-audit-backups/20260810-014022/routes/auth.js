const express = require("express");
const bcrypt = require("bcryptjs");
const db = require("../database");

const router = express.Router();


router.post("/register", async (req,res)=>{

const {name,email,password}=req.body;

const hash = await bcrypt.hash(password,10);

const {data,error}=await db
.from("users")
.insert([{
name,
email,
password:hash
}])
.select();


if(error)
return res.status(400).json({
error:error.message
});


res.json({
message:"Account created",
user:data[0]
});

});


router.post("/login", async(req,res)=>{

const {email,password}=req.body;


const {data,error}=await db
.from("users")
.select("*")
.eq("email",email)
.single();


if(error)
return res.status(400).json({
error:"User not found"
});


const match=await bcrypt.compare(
password,
data.password
);


if(!match)
return res.status(400).json({
error:"Wrong password"
});


req.session.user=data;


res.json({
message:"Login successful",
user:data
});


});


module.exports=router;
