#!/data/data/com.termux/files/usr/bin/bash

echo "=== Fix API Security Route ==="


mkdir -p api/developer


cat > api/developer/security.js <<'JS'
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
.from("api_security_analytics")
.select("*");


res.json({

success:true,

security: result.data || []

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


if "/api/developer/security" not in s:

    s=s.replace(
    "module.exports = app;",
    """

const developerSecurity =
require("./api/developer/security");

app.get(
"/api/developer/security",
developerSecurity
);


module.exports = app;
"""
    )

    open(p,"w").write(s)

PY



node -c server.js


git add .

git commit -m "Register API security dashboard route"


echo "Security route added"

