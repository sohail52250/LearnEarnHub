const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res)=>{
 try{

  const keys=await db
   .from("developer_keys")
   .select("*");

  const actions=await db
   .from("api_key_actions")
   .select("*")
   .order("created_at",{ascending:false})
   .limit(10);

  if(keys.error) throw keys.error;
  if(actions.error) throw actions.error;

  res.json({
   success:true,
   stats:{
    total_keys:keys.data.length,
    blocked_keys:keys.data.filter(k=>k.blocked===true).length,
    active_keys:keys.data.filter(k=>k.status==="active").length
   },
   recent_actions:actions.data
  });

 }catch(e){
  res.status(500).json({
   error:e.message
  });
 }
};
