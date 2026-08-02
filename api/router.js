const express=require("express");
const app=express();

app.use(express.json());


app.get("/status",(req,res)=>{
 res.json({
  success:true,
  service:"LearnEarnHub API Router"
 });
});


app.get("/jobs",(req,res)=>{
 res.json({
  success:true,
  jobs:[]
 });
});


app.get("/feeds",(req,res)=>{
 res.json({
  success:true,
  message:"External feed system active"
 });
});


module.exports=app;
