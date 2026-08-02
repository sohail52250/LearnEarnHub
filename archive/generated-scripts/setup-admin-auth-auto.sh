#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Admin Auth Protection Setup ==="

mkdir -p middleware



cat > middleware/admin-auth.js <<'JS'
require("dotenv").config();


const ADMIN_EMAILS = (

process.env.ADMIN_EMAILS || ""

)
.split(",")
.map(x=>x.trim())
.filter(Boolean);



function adminAuth(req,res,next){


const email =
req.headers["x-user-email"];



if(!email){

return res.status(401).json({

error:"Admin login required"

});

}



if(!ADMIN_EMAILS.includes(email)){


return res.status(403).json({

error:"Access denied"

});

}



next();


}



module.exports=adminAuth;

JS



python3 - <<'PY'

p="server.js"

s=open(p).read()


if "admin-auth" not in s:


s += '''

// Admin authentication middleware

const adminAuth=require("./middleware/admin-auth");


'''


s=s.replace(

'app.get(\n"/api/admin",\nadmin\n);',

'app.get(\n"/api/admin",\nadminAuth,\nadmin\n);'

)


open(p,"w").write(s)


print("server.js updated")

PY



cat >> .env <<'ENV'

# Admin emails separated by comma
ADMIN_EMAILS=admin@example.com

ENV



node -c server.js


echo ""
echo "✅ Admin protection enabled"

echo ""
echo "Update .env:"
echo "ADMIN_EMAILS=your-email@example.com"


