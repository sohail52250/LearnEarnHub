#!/data/data/com.termux/files/usr/bin/bash

set -e

cp api/certificate.js api/certificate-before-security.js


cat > api/certificate.js <<'JS'
const db = require("../database");


module.exports = async(req,res)=>{

try{


if(req.method !== "GET"){

return res.status(405).json({
error:"GET only"
});

}


// Public verification by certificate code

const {code}=req.query;


if(code){

const {data,error}=await db
.from("certificates")
.select(
"certificate_code,certificate_title,issued_at,course_id"
)
.eq("certificate_code",code)
.single();


if(error || !data){

return res.status(404).json({
valid:false,
error:"Certificate not found"
});

}


return res.json({

valid:true,

certificate:data

});

}


// Logged-in user certificates

if(!req.user){

return res.status(401).json({
error:"Login required"
});

}


const {data,error}=await db
.from("certificates")
.select(
"certificate_code,certificate_title,issued_at,course_id"
)
.eq("user_id",req.user.id);


return res.json({

success:!error,

certificates:data || []

});


}catch(err){

console.error(err);

res.status(500).json({
error:"Verification failed"
});

}

};
JS


git add api/certificate.js

git commit -m "Secure certificate verification API"

git push

echo "DONE"
