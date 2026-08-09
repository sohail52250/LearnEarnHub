const express=require("express");
const app=express();

app.use(express.json());


const routes={

"/dashboard":require("./dashboard"),
"/certificate":require("./certificate"),
"/complete-lesson":require("./complete-lesson"),
"/auth":require("./auth"),
"/user-dashboard":require("./user-dashboard"),
"/jobs/import":require("./jobs/import"),
"/jobs/apply":require("./jobs/apply"),
"/jobs/my-applications":require("./jobs/my-applications"),
"/partner/jobs":require("./partner/jobs"),
"/external/jobs-feed":require("./external/jobs-feed"),
"/feeds/list":require("./feeds/list"),
"/feeds/refresh":require("./feeds/refresh"),
"/sources/opportunities":require("./sources/opportunities"),
"/developer/dashboard":require("./developer/dashboard"),
"/developer/usage":require("./developer/usage"),
"/developer/security":require("./developer/security"),
"/developer/key-control":require("./developer/key-control"),
"/developer/regenerate-key":require("./developer/regenerate-key")

};


Object.keys(routes).forEach(path=>{

app.use(path,routes[path]);

});


app.get("/status",(req,res)=>{

res.json({
success:true,
service:"LearnEarnHub API",
mode:"consolidated"
});

});


module.exports=app;
