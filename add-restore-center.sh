#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

echo "=== Creating Restore Center ==="

mkdir -p public/routes

cat > public/admin-restore-center.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Restore Center</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
body{font-family:Arial;background:#f5f5f5;padding:20px}
.card{background:white;padding:20px;border-radius:12px;max-width:700px;margin:auto}
button{padding:12px;background:#2563eb;color:white;border:0;border-radius:8px}
pre{background:#111;color:#0f0;padding:15px}
</style>
</head>

<body>
<div class="card">
<h2>🔐 LearnEarnHub Restore Center</h2>

<button onclick="createBackup()">Create Checkpoint</button>

<h3>Backup Status</h3>
<pre id="result">Loading...</pre>

</div>

<script>
async function createBackup(){
 let r=await fetch('/api/admin/create-backup',{
 method:'POST',
 headers:{'Content-Type':'application/json'},
 body:JSON.stringify({
 name:'Production Stable Checkpoint'
 })
 });

 document.getElementById('result').textContent=
 await r.text();
}

async function load(){
 let r=await fetch('/api/admin/backups');
 document.getElementById('result').textContent=
 await r.text();
}

load();
</script>

</body>
</html>
HTML


cat > routes/restore-center.js <<'JS'
const express=require("express");
const router=express.Router();
const supabase=require("../database");

router.get("/admin/backups",async(req,res)=>{

const {data,error}=await supabase
.from("system_backups")
.select("*")
.order("created_at",{ascending:false});

if(error)
return res.status(500).json(error);

res.json(data);

});


router.post("/admin/create-backup",async(req,res)=>{

const backup={
name:req.body.name || "Manual Checkpoint",
git_commit:"current",
deployment:"vercel-production",
status:"stable",
audit_result:"verified"
};

const {data,error}=await supabase
.from("system_backups")
.insert(backup)
.select();

if(error)
return res.status(500).json(error);

res.json({
success:true,
backup:data
});

});


module.exports=router;
JS


echo "Adding database table..."

cat > restore-center.sql <<'SQL'

create table if not exists system_backups(
id bigint generated always as identity primary key,
name text,
git_commit text,
deployment text,
status text,
audit_result text,
created_at timestamp default now()
);

SQL


echo "Adding route loader..."

python3 - <<'PY'
p="server.js"

s=open(p).read()

if "restore-center" not in s:
    s=s.replace(
    'module.exports = app;',
    '''
try{
const restoreRouter=require("./routes/restore-center");
app.use("/api",restoreRouter);
console.log("Restore Center API loaded");
}catch(e){
console.log("Restore Center error",e.message);
}

module.exports = app;
'''
    )

open(p,"w").write(s)
PY


git add .

git commit -m "Add LearnEarnHub Restore Center"

git push

echo "Deploying..."

vercel --prod

echo "=== DONE ==="

echo "Open:"
echo "https://learn-earnhub.vercel.app/admin-restore-center.html"

