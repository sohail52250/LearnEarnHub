#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Platform Core V2"
echo "======================================"

mkdir -p database

cat > database/unified-notifications.sql <<'SQL'
CREATE TABLE IF NOT EXISTS notifications (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid,
    title text,
    message text,
    is_read boolean DEFAULT false,
    created_at timestamp DEFAULT now()
);

CREATE TABLE IF NOT EXISTS messages (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    sender_id uuid,
    receiver_id uuid,
    message text,
    created_at timestamp DEFAULT now()
);
SQL

cat > api/notifications.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){
const user_id=req.query.user_id;

const {data,error}=await db
.from("notifications")
.select("*")
.eq("user_id",user_id)
.order("created_at",{ascending:false});

return res.json({success:true,data,error});
}

res.status(405).json({error:"Method not allowed"});
};
JS

cat > api/messages.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{

if(req.method==="GET"){

const user_id=req.query.user_id;

const {data,error}=await db
.from("messages")
.select("*");

return res.json({success:true,data,error});
}

if(req.method==="POST"){

const {data,error}=await db
.from("messages")
.insert([req.body])
.select();

return res.json({
success:!error,
data,
error
});
}

res.status(405).json({error:"Method not allowed"});
};
JS

cat > public/dashboard-v2.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard V2</title>
</head>
<body>

<h1>LearnEarnHub Dashboard</h1>

<ul>
<li><a href="/unified-profile.html">Profile</a></li>
<li><a href="/enterprise-hiring.html">Jobs</a></li>
<li><a href="/courses.html">Courses</a></li>
<li><a href="/notifications.html">Notifications</a></li>
<li><a href="/messages.html">Messages</a></li>
</ul>

</body>
</html>
HTML

cat > public/notifications.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Notifications</title>
</head>
<body>
<h1>Notifications</h1>
<div id="list"></div>

<script>
fetch("/api/notifications?user_id="+localStorage.getItem("user_id"))
.then(r=>r.json())
.then(d=>{
list.innerHTML=JSON.stringify(d.data||[]);
});
</script>

</body>
</html>
HTML

cat > public/messages.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Messages</title>
</head>
<body>
<h1>Messages</h1>

<textarea id="msg"></textarea>
<button onclick="sendMsg()">Send</button>

<script>
async function sendMsg(){

await fetch("/api/messages",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

sender_id:localStorage.getItem("user_id"),

receiver_id:"demo",

message:msg.value

})

});

alert("Message sent");

}
</script>

</body>
</html>
HTML

git add .
git commit -m "Platform Core V2 dashboard notifications messaging" || true
git push

echo "======================================"
echo " Platform Core V2 Installed"
echo "======================================"

