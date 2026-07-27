#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Security Hardening V4"
echo "======================================"

mkdir -p middleware


cat > middleware/security.js <<'JS'
const db=require("../database");


async function logSecurity(user_id,action,details){

try{

await db
.from("security_audit_logs")
.insert([{

user_id,
action,
details

}]);

}catch(e){

console.log("Security log error");

}

}



function requireRole(role){

return async(req,res,next)=>{


let userRole=req.headers["x-user-role"];


if(!userRole){

return res.status(401).json({

error:"Authentication required"

});

}



if(userRole!==role && userRole!=="super_admin"){

return res.status(403).json({

error:"Permission denied"

});

}


await logSecurity(

null,

"ACCESS",

"Role checked: "+role

);


next();


};


}



module.exports={

requireRole,

logSecurity

};
JS



cat > database/security-hardening-v4.sql <<'SQL'

CREATE TABLE IF NOT EXISTS api_access_logs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

endpoint text,

method text,

status integer,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS login_security_events(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

event text,

ip_address text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/security-health.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


const logs=await db

.from("api_access_logs")

.select("*")

.order("created_at",{ascending:false})

.limit(20);



res.json({

success:true,

security_status:"active",

recent_logs:logs.data||[]

});


};
JS



cat > public/security-center.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>
Security Center
</title>

<meta charset="UTF-8">

</head>

<body>


<h1>
LearnEarnHub Security Center
</h1>


<div id="status">

Checking security...

</div>


<script>

fetch("/api/security-health")

.then(r=>r.json())

.then(d=>{


status.innerHTML=

"Security Status: "

+d.security_status;


});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add security hardening V4 foundation" || true

git push


echo "======================================"
echo " Security Hardening V4 Completed"
echo "======================================"

