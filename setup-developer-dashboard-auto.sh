#!/data/data/com.termux/files/usr/bin/bash

echo "=== Creating developer dashboard API ==="

mkdir -p api/developer

cat > api/developer/dashboard.js <<'JS'
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
JS

echo "Dashboard API created"

python - <<'PY'
from pathlib import Path

p=Path("server.js")
s=p.read_text()

if '"/api/developer/dashboard"' not in s:
    s=s.replace(
    'module.exports = app;',
    '''
app.get("/api/developer/dashboard",
require("./api/developer/dashboard"));

module.exports = app;
'''
    )
    p.write_text(s)
    print("Dashboard route added")
else:
    print("Dashboard route already exists")
PY

git add .
git commit -m "Add developer dashboard stats API"
git push

echo "=== Completed ==="
