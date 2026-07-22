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
app.use("/api/courses", require("./courses"));
app.use("/api/complete-course", require("./complete-course"));



app.get("/api/dashboard", async (req,res)=>{

try{

const { createClient } = require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

const {user_id}=req.query;

if(!user_id){
 return res.json({
  success:false,
  error:"missing user_id"
 });
}

const {data:user,error:userError}=await db
.from("users")
.select("id,name,email,language,points,created_at")
.eq("id",user_id)
.single();

if(userError){
 return res.json({
  success:false,
  step:"user",
  error:userError
 });
}

const {data:progress,error:progressError}=await db
.from("user_progress")
.select("*")
.eq("user_id",user_id);

if(progressError){
 return res.json({
  success:false,
  step:"progress",
  error:progressError
 });
}

res.json({
 success:true,
 user:user,
 progress:progress
});

}catch(e){

res.status(500).json({
 success:false,
 error:e.message
});

}

});

module.exports = app;
