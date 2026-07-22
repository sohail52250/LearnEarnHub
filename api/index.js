const express = require("express");

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended:true}));

app.get("/api/status",(req,res)=>{
  res.json({
    name:"Learn & Earn Hub",
    status:"Running",
    database:"Supabase"
  });
});


app.use("/api/users", require("./users"));
app.use("/api/ads", require("./ads"));
app.use("/api/courses", require("./courses"));


module.exports = app;
