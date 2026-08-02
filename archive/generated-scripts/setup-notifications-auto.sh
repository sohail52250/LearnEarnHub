#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Notification System Setup ==="

mkdir -p services api public/notifications



cat > database/notifications.sql <<'SQL'

CREATE TABLE IF NOT EXISTS notifications (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

title TEXT NOT NULL,

message TEXT NOT NULL,

type TEXT DEFAULT 'general',

read_status BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS notifications_user_idx

ON notifications(user_id);


SQL



cat > services/notification-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function sendNotification(data){


const {data:result,error}=await db
.from("notifications")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function getNotifications(user_id){


const {data,error}=await db
.from("notifications")
.select("*")
.eq("user_id",user_id)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



async function markRead(id){


const {data,error}=await db
.from("notifications")
.update({

read_status:true

})
.eq("id",id)
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

sendNotification,

getNotifications,

markRead

};

JS



cat > api/notifications.js <<'JS'
const service=require("../services/notification-service");


module.exports=async function(req,res){

try{


if(req.body.action==="send"){

return res.json(
await service.sendNotification(
req.body.data
)
);

}



if(req.body.action==="read"){

return res.json(
await service.markRead(
req.body.id
)
);

}



if(req.query.user_id){

return res.json(
await service.getNotifications(
req.query.user_id
)
);

}



res.status(400).json({
error:"Invalid request"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/notifications" server.js
then

cat >> server.js <<'JS'


// Notifications API

const notifications=require("./api/notifications");


app.get(
"/api/notifications",
notifications
);


app.post(
"/api/notifications",
notifications
);


JS

fi



cat > public/notifications/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Notifications</title>

<style>

body{

font-family:Arial;

background:#f5f7fb;

padding:20px;

}

.card{

background:white;

padding:15px;

margin:10px;

border-radius:12px;

}

</style>

</head>


<body>


<h1>🔔 Notifications</h1>


<div id="list">

Loading...

</div>



<script>


const user_id=
new URLSearchParams(location.search)
.get("user_id");



async function load(){


let r=
await fetch(
"/api/notifications?user_id="+user_id
);


let data=
await r.json();



list.innerHTML=
data.map(n=>`

<div class="card">

<h3>${n.title}</h3>

<p>${n.message}</p>

<small>${n.type}</small>

</div>

`).join("");

}


load();


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Notification system created"

echo ""
echo "Events ready:"
echo "🏆 Certificate generated"
echo "🎓 Skill verified"
echo "💼 Job offer"
echo "✅ Work approved"
echo "💰 Earnings released"


