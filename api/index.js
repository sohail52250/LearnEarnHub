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


app.use("/api/auth", require("./auth"));
app.use("/api/users", require("./users"));
app.use("/api/ads", require("./ads"));
app.use("/api/courses", require("./courses"));\napp.use("/api/complete-course", require("./complete-course"));


module.exports = app;
