#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating API usage table ==="

cat > /tmp/api_usage.sql <<'SQL'
CREATE TABLE IF NOT EXISTS public.api_usage_logs (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    api_key_id bigint,
    endpoint text,
    created_at timestamptz DEFAULT now()
);
SQL

echo "Run this SQL in Supabase SQL Editor:"
cat /tmp/api_usage.sql

echo
echo "=== Creating usage API route ==="

mkdir -p api/developer

cat > api/developer/usage.js <<'JS'
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
JS

echo "Usage route created"

echo "=== Done ==="
