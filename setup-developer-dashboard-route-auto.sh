#!/data/data/com.termux/files/usr/bin/bash

echo "=== Developer Dashboard API Route Setup ==="

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


const keys = await db
.from("api_partner_keys")
.select(
"id,partner_id,status,request_limit,last_used_at"
);



const events = await db
.from("api_dashboard_logs")
.select(
"id,action,created_at",
{
count:"exact"
}
);



res.json({

success:true,

api_keys:
keys.data || [],

total_events:
events.count || 0

});


}

catch(error){

res.status(500).json({

error:error.message

});

}


};
JS



python3 - <<'PY'
import json

with open("vercel.json") as f:
    v=json.load(f)

routes=v.get("routes",[])

exists=False

for r in routes:
    if r.get("src")=="/api/developer/(.*)":
        exists=True

if not exists:
    routes.insert(
        0,
        {
        "src":"/api/developer/(.*)",
        "dest":"server.js"
        }
    )

v["routes"]=routes

with open("vercel.json","w") as f:
    json.dump(v,f,indent=2)

PY


git add .

git commit -m "Add developer dashboard API endpoint"


echo "DONE"

