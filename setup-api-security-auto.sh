#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating API security middleware ==="

mkdir -p middleware

cat > middleware/api-key-security.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

module.exports=async(req,res,next)=>{

 try{

  const apiKey=req.headers["x-api-key"];

  if(!apiKey){
   return res.status(401).json({
    error:"Missing API key"
   });
  }

  const {data:key,error}=await db
   .from("developer_keys")
   .select("*")
   .eq("api_key",apiKey)
   .maybeSingle();

  if(error) throw error;

  if(!key){
   return res.status(403).json({
    error:"Invalid API key"
   });
  }

  if(key.blocked){
   return res.status(403).json({
    error:"API key blocked"
   });
  }

  await db
   .from("api_usage_logs")
   .insert({
    api_key_id:key.id,
    endpoint:req.path
   });

  req.apiKey=key;

  next();

 }catch(e){

  res.status(500).json({
   error:e.message
  });

 }

};
JS

echo "Security middleware created"

git add .
git commit -m "Add API key security middleware"
git push

echo "=== Completed ==="
