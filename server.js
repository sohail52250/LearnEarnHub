require("dotenv").config();

const express = require("express");
const app = express();
app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.use(express.static("public"));



app.get("/api/status",(req,res)=>{
  res.json({
    name:"Learn & Earn Hub",
    status:"Running",
    database:"Supabase"
  });
});




    
// Serve HTML pages from public folder
app.use((req,res,next)=>{
    if(req.method === "GET" && req.path.endsWith(".html")){
        res.sendFile(__dirname + "/public" + req.path);
    } else {
        next();
    }
});

try{
const restoreRouter=require("./routes/restore-center");
app.use("/api",restoreRouter);
console.log("Restore Center API loaded");
}catch(e){
console.log("Restore Center error",e.message);
}

module.exports = app;


try{
const aiDealRouter=require("./routes/ai-deal-room");
app.use("/api",aiDealRouter);
console.log("AI Deal API loaded");
}catch(e){
console.log("AI Deal API error",e.message);
}

