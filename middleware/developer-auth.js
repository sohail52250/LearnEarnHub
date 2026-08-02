const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res,next)=>{

 try{

 const token=req.headers.authorization?.replace("Bearer ","");

 if(!token){
  return res.status(401).json({
   error:"Missing login token"
  });
 }

 const {data,error}=await db.auth.getUser(token);

 if(error || !data.user){
  return res.status(401).json({
   error:"Invalid session"
  });
 }

 req.user=data.user;

 next();

 }catch(e){

 res.status(500).json({
  error:e.message
 });

 }

};
