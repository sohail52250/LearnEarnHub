#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub API Key Control Center Setup ==="


mkdir -p api/developer
mkdir -p public/partner


cat > api/developer/key-control.js <<'JS'
const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async(req,res)=>{


try{


if(req.method==="GET"){


const result =
await db
.from("api_partner_keys")
.select("*");


return res.json({

success:true,

keys:result.data || []

});

}



if(req.method==="POST"){


const {
action,
id
}=req.body;



if(action==="block"){

await db.rpc(
"block_api_key",
{
p_key_id:id
}
);


}



if(action==="unblock"){

await db.rpc(
"unblock_api_key",
{
p_key_id:id
}
);


}



return res.json({

success:true,

action

});

}


res.status(405).json({

error:"Method not allowed"

});



}

catch(e){

res.status(500).json({

error:e.message

});

}


};
JS



python3 - <<'PY'

p="server.js"

s=open(p).read()


if "/api/developer/key-control" not in s:

 s=s.replace(
 "module.exports = app;",
 """

const keyControl =
require("./api/developer/key-control");

app.get(
"/api/developer/key-control",
keyControl
);

app.post(
"/api/developer/key-control",
keyControl
);


module.exports = app;
"""
 )

 open(p,"w").write(s)

PY



cat > public/partner/key-control.html <<'HTML'

<!DOCTYPE html>

<html>

<head>

<title>
LearnEarnHub API Key Control
</title>

<style>

body{
font-family:Arial;
padding:30px;
}

button{
padding:8px;
margin:5px;
}

.card{
background:#eee;
padding:15px;
margin:10px;
border-radius:10px;
}

</style>

</head>


<body>


<h1>
API Key Control Center
</h1>


<div id="keys">
Loading...
</div>



<script>


async function load(){


let r=await fetch(
"/api/developer/key-control"
);


let d=await r.json();



document.getElementById("keys")
.innerHTML="";


d.keys.forEach(k=>{


document.getElementById("keys")
.innerHTML+=`

<div class="card">

<b>${k.key_name}</b>

<br>

${k.api_key}

<br>

Status:
${k.status}

<br>


<button onclick="changeKey(${k.id},'block')">
Block
</button>


<button onclick="changeKey(${k.id},'unblock')">
Unblock
</button>


</div>

`;

});


}



async function changeKey(id,action){


await fetch(
"/api/developer/key-control",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({
id,
action
})

});


load();

}



load();


</script>


</body>

</html>

HTML



git add .

git commit -m "Add API key control center"


echo ""
echo "DONE"
echo ""
echo "Deploy:"
echo "vercel --prod"

