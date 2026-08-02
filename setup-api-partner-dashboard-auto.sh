#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub API Partner Dashboard ==="

mkdir -p public/partner


cat > public/partner/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>

<title>LearnEarnHub API Partner Dashboard</title>

<style>

body{
font-family:Arial;
background:#f4f4f4;
padding:30px;
}

.card{
background:white;
padding:20px;
border-radius:12px;
margin-bottom:20px;
}

button{
padding:10px;
}

</style>

</head>

<body>


<h1>API Partner Dashboard</h1>


<div class="card">

<h2>Partner Status</h2>

<pre id="status">
Loading...
</pre>

</div>


<div class="card">

<h2>Developer Tools</h2>

<a href="/swagger/">
Swagger API Docs
</a>

<br><br>

<a href="/developer/">
Developer Portal
</a>

</div>


<script>

async function load(){

let r=await fetch(
"/api/developer/dashboard"
);

let d=await r.json();

document.getElementById("status")
.innerHTML=
JSON.stringify(d,null,2);

}


load();

</script>


</body>
</html>
HTML



cat > api/developer/dashboard.js <<'JS'
const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async(req,res)=>{

try{


const keys =
await db
.from("api_partner_keys")
.select(
"partner_id,status,request_limit,last_used_at"
);



const logs =
await db
.from("api_dashboard_logs")
.select("*",{count:"exact"});



res.json({

success:true,

keys:
keys.data || [],

events:
logs.count || 0

});


}

catch(e){

res.status(500)
.json({

error:e.message

});

}

};
JS



git add .

git commit -m "Add API partner dashboard UI"


echo ""
echo "DONE"
echo "URL:"
echo "https://learn-earnhub.vercel.app/partner/"

