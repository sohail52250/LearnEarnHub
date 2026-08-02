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



    
// Developer Portal routes
const devDashboard=require("../backend-api/developer/dashboard");
const devUsage=require("../backend-api/developer/usage");
const devSecurity=require("../backend-api/developer/security");
const devKey=require("../backend-api/developer/key-control");
const devRegenerate=require("../backend-api/developer/regenerate-key");

app.use("/developer/dashboard",devDashboard);
app.use("/developer/usage",devUsage);
app.use("/developer/security",devSecurity);
app.use("/developer/key-control",devKey);
app.use("/developer/regenerate-key",devRegenerate);




// Jobs and opportunity feeds
const externalJobs=require("../backend-api/external/jobs-feed");
const sourceOpportunities=require("../backend-api/sources/opportunities");
const partnerJobs=require("../backend-api/partner/jobs");

app.use("/external/jobs-feed",externalJobs);
app.use("/sources/opportunities",sourceOpportunities);
app.use("/partner/jobs",partnerJobs);


module.exports=app;
