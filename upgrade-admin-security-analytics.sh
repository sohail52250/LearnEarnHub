#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Admin Security Upgrade"
echo "======================================"

mkdir -p database


cat > database/admin_security_analytics_upgrade.sql <<'SQL'

CREATE TABLE IF NOT EXISTS admin_roles (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid REFERENCES users(id),
role_name text DEFAULT 'admin',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS admin_permissions (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
role_id uuid REFERENCES admin_roles(id),
permission_name text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS admin_activity_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
admin_id uuid,
action text,
target text,
details text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS security_logs (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
event_type text,
ip_address text,
details text,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS platform_analytics (
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
metric_name text,
metric_value integer DEFAULT 0,
created_at timestamp DEFAULT now()
);

SQL



echo "Creating admin dashboard API..."

cat > api/admin-dashboard.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const users=await db
.from("users")
.select("id",{count:"exact"});

const courses=await db
.from("courses")
.select("id",{count:"exact"});

const tasks=await db
.from("earning_tasks")
.select("id",{count:"exact"});


return res.json({
success:true,
statistics:{
users:users.count || 0,
courses:courses.count || 0,
tasks:tasks.count || 0
}
});

};
JS



echo "Creating user management API..."

cat > api/admin-users.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("users")
.select(`
id,
name,
email,
phone,
language,
points,
created_at
`);

return res.json({
data,
error
});

};
JS



echo "Creating security log API..."

cat > api/security-log.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("security_logs")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



echo "Creating analytics API..."

cat > api/platform-analytics.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("platform_analytics")
.select("*")
.order("created_at",{ascending:false});


return res.json({
data,
error
});

};
JS



echo "Creating admin activity API..."

cat > api/admin-activity.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

const {data,error}=await db
.from("admin_activity_logs")
.insert([req.body])
.select();


return res.json({
success:!error,
data,
error
});

};
JS



git add database/admin_security_analytics_upgrade.sql api/admin-dashboard.js api/admin-users.js api/security-log.js api/platform-analytics.js api/admin-activity.js

git commit -m "Add admin control center security and analytics foundation" || true

git push


echo "======================================"
echo " Admin Control Center Added"
echo "======================================"

echo "Run SQL:"
echo "database/admin_security_analytics_upgrade.sql"

