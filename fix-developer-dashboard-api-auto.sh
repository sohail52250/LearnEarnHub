#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Developer Dashboard API Route ==="


mkdir -p api/developer


cat > api/developer/dashboard.js <<'JS'
const {createClient}=require("@supabase/supabase-js");
require("dotenv").config();

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


module.exports=async function(req,res){

try{

const keys=await db
.from("api_partner_keys")
.select("*");


const events=await db
.from("api_dashboard_logs")
.select("*",{count:"exact"});


res.json({

success:true,

api_keys:keys.data || [],

total_events:events.count || 0

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
JS



python3 - <<'PY'

p="server.js"

s=open(p).read()

if "api/developer/dashboard" not in s:

    insert="""


// Developer Dashboard API
const developerDashboard =
require("./api/developer/dashboard");

app.get(
"/api/developer/dashboard",
developerDashboard
);

"""

    s=s.replace(
    "module.exports = app;",
    insert+"\nmodule.exports = app;"
    )

    open(p,"w").write(s)

PY



node -c server.js


git add .

git commit -m "Register developer dashboard API route"


echo "Developer API route added"

