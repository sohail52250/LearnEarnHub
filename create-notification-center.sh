
#!/data/data/com.termux/files/usr/bin/bash

cat > public/notifications.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Notifications</title>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/supabase-config.js"></script>
</head>

<body>

<h1>🔔 Notifications</h1>

<div id="notifications">
Loading...
</div>

<script src="/notifications.js"></script>

</body>
</html>
HTML


cat > public/notifications.js <<'JS'

const client=supabaseClient;

async function loadNotifications(){

const user=JSON.parse(
localStorage.getItem("user") || "null"
);

if(!user){
document.body.innerHTML="Please login";
return;
}

const {data,error}=await client
.from("business_notifications")
.select("*")
.or(`business_id.eq.${user.id},learner_id.eq.${user.id}`)
.order("created_at",{ascending:false});

if(error){
console.log(error);
return;
}

document.getElementById("notifications").innerHTML=

(data||[]).map(n=>`

<div class="card">

<h3>${n.title}</h3>

<p>${n.message}</p>

<p>
${n.read ? "✅ Read" : "🔴 Unread"}
</p>

<button onclick="markRead('${n.id}')">
Mark Read
</button>

</div>

`).join("")
||
"No notifications";

}


async function markRead(id){

await client
.from("business_notifications")
.update({read:true})
.eq("id",id);

loadNotifications();

}

document.addEventListener(
"DOMContentLoaded",
loadNotifications
);

JS

echo "Notification Center Created"

