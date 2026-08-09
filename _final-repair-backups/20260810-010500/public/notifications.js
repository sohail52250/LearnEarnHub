
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

