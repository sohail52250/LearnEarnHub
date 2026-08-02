#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Messaging System Setup ==="

mkdir -p services api/messages public/messages



cat > database/messages.sql <<'SQL'

CREATE TABLE IF NOT EXISTS messages (

id BIGSERIAL PRIMARY KEY,

sender_id UUID NOT NULL,

receiver_id UUID NOT NULL,

job_id BIGINT,

message TEXT NOT NULL,

read_status BOOLEAN DEFAULT false,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS messages_receiver_idx

ON messages(receiver_id);


CREATE INDEX IF NOT EXISTS messages_sender_idx

ON messages(sender_id);


SQL



cat > services/message-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function sendMessage(data){


const {data:result,error}=await db
.from("messages")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function inbox(user_id){


const {data,error}=await db
.from("messages")
.select("*")
.eq("receiver_id",user_id)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={

sendMessage,

inbox

};

JS



cat > api/messages/index.js <<'JS'
const service=require("../../services/message-service");


module.exports=async function(req,res){

try{


if(req.body.action==="send"){

return res.json(
await service.sendMessage(
req.body.data
)
);

}



if(req.query.user_id){

return res.json(
await service.inbox(
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



if ! grep -q "/api/messages" server.js
then

cat >> server.js <<'JS'


// Messaging API

const messages=require("./api/messages");


app.get(
"/api/messages",
messages
);


app.post(
"/api/messages",
messages
);


JS

fi



cat > public/messages/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Messages</title>


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


input,textarea,button{

width:90%;

padding:10px;

margin:5px;

}


button{

background:#1565c0;

color:white;

border:0;

}

</style>


</head>


<body>


<h1>💬 Messages</h1>


<div class="card">


<input id="sender" placeholder="Sender ID">


<input id="receiver" placeholder="Receiver ID">


<textarea id="message" placeholder="Message"></textarea>


<button onclick="send()">

Send

</button>


</div>



<div id="inbox"></div>



<script>


async function send(){


await fetch(
"/api/messages",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"send",

data:{

sender_id:sender.value,

receiver_id:receiver.value,

message:message.value

}

})

});


alert("Message sent ✅");


}


</script>


</body>

</html>
HTML



node -c server.js


echo ""

echo "✅ Messaging System Created"

echo ""

echo "Features:"
echo "💬 Employer ↔ Learner chat foundation"
echo "📩 Inbox"
echo "🔒 Database based messaging"


