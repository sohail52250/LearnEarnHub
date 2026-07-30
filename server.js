require("dotenv").config();

const express = require("express");
const app = express();

try{
app.use("/api/courses", require("./routes/courses"));
console.log("Courses API loaded");
}catch(e){
console.log("Courses API error:",e.message);
}


app.use(express.json());

app.post("/api/test-post",(req,res)=>{
  res.json({
    success:true,
    source:"server.js"
  });
});

try{
  const unlockCourseRouter=require("./routes/unlock-course");
  app.use("/api/unlock-course", unlockCourseRouter);
  console.log("Unlock Course API loaded");
}catch(e){
  console.log("Unlock Course API error:",e.message);
}




});
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




try{
const aiDealRouter=require("./routes/ai-deal-room");
app.use("/api",aiDealRouter);
console.log("AI Deal API loaded");
}catch(e){
console.log("AI Deal API error",e.message);
}

module.exports = app;
