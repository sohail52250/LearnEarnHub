#!/data/data/com.termux/files/usr/bin/bash

echo "=== Fix API Usage Route ==="


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

const result =
await db
.from("api_usage_dashboard")
.select("*");


res.json({

success:true,

usage: result.data || []

});


}

catch(e){

res.status(500).json({

error:e.message

});

}

};
JS



python3 - <<'PY'

p="server.js"

s=open(p).read()


if "/api/developer/usage" not in s:

    s=s.replace(
    "module.exports = app;",
    """

const developerUsage =
require("./api/developer/usage");

app.get(
"/api/developer/usage",
developerUsage
);


module.exports = app;
"""
    )

    open(p,"w").write(s)

PY



node -c server.js


git add .

git commit -m "Register API usage dashboard route"


echo "Route added"

