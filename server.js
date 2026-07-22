require("dotenv").config();

const express = require("express");
const app = express();

app.get("/",(req,res)=>{
  res.json({
    app:"Learn & Earn Hub",
    version:"1.0"
  });
});

app.get("/api/status",(req,res)=>{
  res.json({
    name:"Learn & Earn Hub",
    status:"Running",
    database:"Supabase"
  });
});

const dbtest = require("./api/dbtest");

app.get("/api/dbtest",dbtest);

module.exports = app;
