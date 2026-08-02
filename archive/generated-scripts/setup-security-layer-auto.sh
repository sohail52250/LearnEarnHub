#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Security Layer Setup ==="

mkdir -p middleware services api



cat > middleware/auth-guard.js <<'JS'
require("dotenv").config();


const adminEmails=
(process.env.ADMIN_EMAILS || "")
.split(",")
.map(x=>x.trim())
.filter(Boolean);



function adminGuard(req,res,next){


const email=
req.headers["x-user-email"];



if(!email){

return res.status(401).json({

error:"Authentication required"

});

}



if(!adminEmails.includes(email)){


return res.status(403).json({

error:"Admin access denied"

});

}



next();


}



module.exports={
adminGuard
};

JS



cat > services/audit-log-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function logAction(data){


const {error}=await db
.from("audit_logs")
.insert(data);



if(error) throw error;


return true;


}



module.exports={
logAction
};

JS



cat > database/security.sql <<'SQL'

CREATE TABLE IF NOT EXISTS audit_logs (

id BIGSERIAL PRIMARY KEY,

user_email TEXT,

action TEXT,

target TEXT,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS audit_logs_date_idx

ON audit_logs(created_at);


SQL



cat > middleware/rate-limit.js <<'JS'
const requests={};


function rateLimit(req,res,next){


const ip=
req.headers["x-forwarded-for"] ||
req.socket.remoteAddress;



requests[ip]=(requests[ip]||0)+1;



if(requests[ip]>100){


return res.status(429).json({

error:"Too many requests"

});

}



next();


}



module.exports=rateLimit;

JS



python3 - <<'PY'
p="server.js"

try:

s=open(p).read()

if "rateLimit" not in s:

s=s.replace(
'const app = express();',
'const app = express();\nconst rateLimit=require("./middleware/rate-limit");\napp.use(rateLimit);'
)

open(p,"w").write(s)

print("server.js security middleware added")

except Exception as e:

print(e)

PY



node -c server.js



echo ""
echo "✅ Security layer created"

echo ""
echo "Added:"
echo "🔐 Admin guard"
echo "📝 Audit logs"
echo "🚦 Rate limit"
echo "🛡 API protection foundation"


