#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Backup ==="

cp api/certificate.js api/certificate-before-admin-control.js 2>/dev/null || true


echo "=== Create certificate admin API ==="

cat > api/admin-certificate-control.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(!req.user){

return res.status(401).json({
error:"Login required"
});

}


if(req.user.role!=="admin"){

return res.status(403).json({
error:"Admin access required"
});

}


const {
action,
certificate_code,
reason
}=req.body;



if(!certificate_code){

return res.status(400).json({
error:"Certificate code required"
});

}



if(action==="approve"){


const {data,error}=await db
.from("certificates")
.update({

status:"approved",

approved_by:req.user.id,

approved_at:new Date().toISOString()

})
.eq(
"certificate_code",
certificate_code
)
.select();


return res.json({

success:!error,

certificate:data,

error

});


}



if(action==="revoke"){


const {data,error}=await db
.from("certificates")
.update({

status:"revoked",

revoked_reason:
reason || "No reason provided",

revoked_by:req.user.id,

revoked_at:new Date().toISOString()

})
.eq(
"certificate_code",
certificate_code
)
.select();



return res.json({

success:!error,

certificate:data,

error

});


}



res.status(400).json({

error:"Invalid action"

});


};
JS



echo "=== Create SQL upgrade ==="


cat > database/certificate-security-upgrade.sql <<'SQL'
ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS status text DEFAULT 'pending';

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS approved_by uuid;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS approved_at timestamp;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS revoked_by uuid;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS revoked_at timestamp;

ALTER TABLE certificates
ADD COLUMN IF NOT EXISTS revoked_reason text;
SQL



echo "=== Update verification security ==="


python3 <<'PY'
p="api/certificate.js"

with open(p,encoding="utf8") as f:
 s=f.read()

s=s.replace(
'.select(\n"certificate_code,certificate_title,issued_at,course_id"\n)',
'.select(\n"certificate_code,certificate_title,issued_at,course_id,status"\n)'
)

s=s.replace(
'if(error || !data){',
'if(error || !data || data.status==="revoked"){'
)

s=s.replace(
'valid:true,',
'valid:true,'
)

with open(p,"w",encoding="utf8") as f:
 f.write(s)

PY



echo "=== Git save ==="

git add .

git commit -m "Add certificate approval and revocation controls" || true

git push


echo "DONE"
