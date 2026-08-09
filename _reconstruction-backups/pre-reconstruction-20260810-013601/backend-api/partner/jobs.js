const { createClient } = require("@supabase/supabase-js");
require("dotenv").config();

const db = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports = async(req,res)=>{
 try{

  if(req.method==="GET"){
   const {data,error}=await db
    .from("partner_jobs")
    .select("*")
    .eq("status","approved")
    .order("created_at",{ascending:false});

   if(error) throw error;

   return res.json({
    success:true,
    jobs:data||[]
   });
  }

  if(req.method==="POST"){

   const {company,title,description,reward,currency,website,country,deadline}=req.body;

   const {data,error}=await db
    .from("partner_jobs")
    .insert({
      company,
      title,
      description,
      reward,
      currency,
      website,
      country,
      deadline,
      status:"pending"
    })
    .select()
    .single();

   if(error) throw error;

   return res.json({
    success:true,
    job:data
   });
  }

  res.status(405).json({
   error:"Method not allowed"
  });

 }catch(e){
  res.status(500).json({
   error:e.message
  });
 }
};
