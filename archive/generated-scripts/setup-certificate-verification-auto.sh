#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Certificate Verification Setup ==="

mkdir -p services api public/verify



cat > database/certificate-verification.sql <<'SQL'

CREATE TABLE IF NOT EXISTS certificate_verification (

id BIGSERIAL PRIMARY KEY,

certificate_id BIGINT REFERENCES certificates(id) ON DELETE CASCADE,

verification_code TEXT UNIQUE NOT NULL,

user_id UUID NOT NULL,

skill_name TEXT,

status TEXT DEFAULT 'verified',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS certificate_code_idx

ON certificate_verification(verification_code);


SQL



cat > services/certificate-verification-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function generateCode(){

return "LEH-" +
Date.now();

}



async function createVerification(data){


const code=generateCode();



const {data:result,error}=await db
.from("certificate_verification")
.insert({

certificate_id:data.certificate_id,

user_id:data.user_id,

skill_name:data.skill_name,

verification_code:code,

status:"verified"

})
.select()
.single();



if(error) throw error;


return result;

}



async function verify(code){


const {data,error}=await db
.from("certificate_verification")
.select("*")
.eq("verification_code",code)
.single();



if(error) throw error;


return data;

}



module.exports={

createVerification,

verify

};

JS



cat > api/verify-certificate.js <<'JS'
const service=require("../services/certificate-verification-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createVerification(
req.body.data
)
);

}



if(req.query.code){

return res.json(
await service.verify(
req.query.code
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



if ! grep -q "/api/verify-certificate" server.js
then

cat >> server.js <<'JS'


// Certificate Verification API

const verifyCertificate=require("./api/verify-certificate");


app.get(
"/api/verify-certificate",
verifyCertificate
);


app.post(
"/api/verify-certificate",
verifyCertificate
);


JS

fi



cat > public/verify/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Certificate Verification</title>

<style>

body{

font-family:Arial;

background:#f5f7fb;

padding:20px;

}

.card{

background:white;

padding:20px;

border-radius:12px;

}

input,button{

width:100%;

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


<div class="card">


<h1>🏆 Certificate Verification</h1>


<input id="code" placeholder="Enter Certificate Code">


<button onclick="verify()">

Verify

</button>


<div id="result"></div>


</div>



<script>


async function verify(){


let r=
await fetch(
"/api/verify-certificate?code="+code.value
);


let d=
await r.json();



result.innerHTML=

d.error ?

"❌ Certificate not found"

:

`

<h3>✅ VERIFIED</h3>

Skill:
${d.skill_name}

<br>

Status:
${d.status}

<br>

Code:
${d.verification_code}

`;

}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Certificate verification system created"

echo ""
echo "Public URL:"
echo "/verify/index.html"

echo ""
echo "Flow:"
echo "Certificate"
echo " ↓"
echo "Verification Code"
echo " ↓"
echo "Employer checks skill"


