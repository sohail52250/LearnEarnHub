#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Admin Control Center V3"
echo "======================================"

mkdir -p database


cat > database/admin-control-center-v3.sql <<'SQL'

CREATE TABLE IF NOT EXISTS admin_actions (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

admin_id uuid,

action text,

target_type text,

target_id uuid,

details text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS approval_requests (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

request_type text,

request_id uuid,

status text DEFAULT 'pending',

reviewed_by uuid,

notes text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS revenue_analytics (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

source text,

amount numeric DEFAULT 0,

period text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/admin-control-center.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){


const users=await db
.from("users")
.select("id,name,email")
.limit(100);


const enterprises=await db
.from("enterprise")
.select("*")
.limit(100);


const approvals=await db
.from("approval_requests")
.select("*")
.order("created_at",{ascending:false});


return res.json({

success:true,

users:users.data||[],

enterprises:enterprises.data||[],

approvals:approvals.data||[]

});


}


res.status(405).json({

error:"Method not allowed"

});


};
JS



cat > public/admin-control-center-v3.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
Admin Control Center V3
</title>

<style>

.card{
border:1px solid #ddd;
padding:20px;
margin:10px;
border-radius:10px;
}

</style>

</head>


<body>


<h1>
LearnEarnHub Admin Control Center V3
</h1>


<div id="dashboard">

Loading...

</div>


<script>


fetch("/api/admin-control-center")

.then(r=>r.json())

.then(d=>{


dashboard.innerHTML=`

<div class="card">
<h2>Users</h2>
${(d.users||[]).length}
</div>


<div class="card">
<h2>Enterprises</h2>
${(d.enterprises||[]).length}
</div>


<div class="card">
<h2>Pending Approvals</h2>
${(d.approvals||[]).length}
</div>

`;

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add Admin Control Center V3" || true

git push


echo "======================================"
echo " Admin Control Center V3 Added"
echo "======================================"

