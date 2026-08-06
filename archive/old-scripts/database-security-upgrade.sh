#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Database Security Upgrade"
echo "======================================"


mkdir -p database/audit


cat > database/master-schema-index.sql <<'SQL'

CREATE TABLE IF NOT EXISTS schema_registry(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

module_name text,

table_name text,

version text,

status text DEFAULT 'active',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS security_audit_logs(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,

action text,

ip_address text,

details text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/security-audit.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="POST"){


const {

user_id,

action,

details

}=req.body;


const {data,error}=await db

.from("security_audit_logs")

.insert([{

user_id,

action,

details

}])

.select();


return res.json({

success:!error,

data,

error

});


}


if(req.method==="GET"){


const {data,error}=await db

.from("security_audit_logs")

.select("*")

.order("created_at",{ascending:false});


return res.json({

success:true,

data,

error

});


}


res.status(405).json({

error:"Method not allowed"

});


};
JS



cat > schema-registry-builder.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash

echo "Building schema registry..."

grep -R "create table" . \
--include="*.sql" \
| sed 's/.*create table if not exists //I' \
| sed 's/(.*//' \
| tr -d '"' \
| sort -u > database/all-known-tables.txt


echo "Schema list created:"
cat database/all-known-tables.txt

SH


chmod +x schema-registry-builder.sh

./schema-registry-builder.sh



git add .

git commit -m "Add database registry and security audit foundation" || true

git push


echo "======================================"
echo " Security Upgrade Complete"
echo "======================================"

