#!/data/data/com.termux/files/usr/bin/bash

set -e

cp api/generate-certificate.js api/generate-certificate-before-security.js


cat > api/generate-certificate.js <<'JS'
const db=require("../database");
const {
 createCertificateCode,
 createHash
}=require("./certificate-security");


module.exports=async(req,res)=>{

try{


const user=req.user;


if(!user){

return res.status(401).json({
error:"Login required"
});

}


const {
course_id
}=req.body;


if(!course_id){

return res.status(400).json({
error:"Course required"
});

}


// Check completion

const {data:progress,error:pError}=await db
.from("learning_progress")
.select("*")
.eq("user_id",user.id)
.eq("course_id",course_id)
.eq("completed",true)
.single();


if(pError || !progress){

return res.status(403).json({
error:"Course not completed"
});

}


// Prevent duplicate certificate

const {data:old}=await db
.from("certificates")
.select("*")
.eq("user_id",user.id)
.eq("course_id",course_id)
.single();


if(old){

return res.json({
success:true,
certificate:old
});

}


// Create secure certificate

const code=createCertificateCode();


const hash=createHash({

user:user.id,
course:course_id,
code,
date:new Date()

});


const {data,error}=await db
.from("certificates")
.insert([{

user_id:user.id,

course_id,

certificate_code:code,

certificate_hash:hash,

certificate_title:
"LearnEarnHub Course Certificate",

issued_at:
new Date().toISOString()

}])
.select();


if(error){

throw error;

}


res.json({

success:true,

certificate:data[0]

});


}catch(err){

console.error(err);

res.status(500).json({

error:"Certificate generation failed"

});

}


};
JS


git add api

git commit -m "Secure certificate generation with verification checks" || true

git push

echo "DONE"
