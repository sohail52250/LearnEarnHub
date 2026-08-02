const express=require("express");

const app=express();

app.use(express.json());

app.use((req,res,next)=>{
  if(req.url.startsWith("/api")){
    req.url=req.url.replace(/^\/api/,"") || "/";
  }
  next();
});


app.get("/",(req,res)=>{
res.json({
success:true,
service:"LearnEarnHub API Router"
});
});


app.get("/status",(req,res)=>{
res.json({
name:"Learn & Earn Hub",
status:"Running",
database:"Supabase",
mode:"Single API Router"
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
