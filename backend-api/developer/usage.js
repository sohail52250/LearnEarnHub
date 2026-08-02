const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res)=>{
 try{

  const {data,error}=await db
   .from("api_usage_logs")
   .select("*")
   .order("created_at",{ascending:false})
   .limit(100);

  if(error) throw error;

  res.json({
   success:true,
   usage:data
  });

 }catch(e){
  res.status(500).json({
   error:e.message
  });
 }
};
