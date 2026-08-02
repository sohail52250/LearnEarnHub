#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Admin Verification Console Setup ==="

mkdir -p public/admin-verification api/admin-verification services



cat > services/admin-verification-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function pendingRecords(){


const {data,error}=await db
.from("verification_records")
.select("*")
.eq(
"status",
"pending"
)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



async function updateStatus(id,status){


const {data,error}=await db
.from("verification_records")
.update({

status

})
.eq(
"id",
id
)
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

pendingRecords,

updateStatus

};

JS



cat > api/admin-verification/index.js <<'JS'
const service=require("../../services/admin-verification-service");


module.exports=async function(req,res){

try{


if(req.body.action==="update"){

return res.json(
await service.updateStatus(
req.body.id,
req.body.status
)
);

}



return res.json(
await service.pendingRecords()
);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/admin-verification" server.js
then

cat >> server.js <<'JS'


// Admin Verification Console API

const adminVerification=
require("./api/admin-verification");


app.get(
"/api/admin-verification",
adminVerification
);


app.post(
"/api/admin-verification",
adminVerification
);


JS

fi



cat > public/admin-verification/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Admin Verification</title>

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


button{

padding:8px;

margin:5px;

}

</style>

</head>


<body>


<h1>🔐 Verification Console</h1>


<div id="list">

Loading...

</div>



<script>


async function load(){


let r=
await fetch(
"/api/admin-verification"
);


let data=
await r.json();



list.innerHTML=
data.map(v=>`

<div class="card">

<h3>
${v.reference_code}
</h3>

<p>
Type:
${v.verification_type}
</p>

<p>
Class:
${v.classification}
</p>


<button onclick="update(${v.id},'active')">
Approve
</button>


<button onclick="update(${v.id},'rejected')">
Reject
</button>


</div>

`).join("");

}



async function update(id,status){


await fetch(
"/api/admin-verification",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"update",

id,

status

})

});


load();


}


load();


</script>


</body>

</html>
HTML



node -c server.js


echo ""

echo "✅ Admin Verification Console Created"

echo ""

echo "Features:"

echo "🔍 Review verification records"

echo "✅ Approve"

echo "❌ Reject"

echo "🆔 Reference tracking"

echo "🔐 Admin-only foundation"


