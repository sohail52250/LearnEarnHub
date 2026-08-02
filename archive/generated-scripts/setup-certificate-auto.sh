#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Certificate Auto System Setup ==="


mkdir -p services api



cat > services/certificate-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function checkAndCreateCertificate(
user_id,
course_id
){

const {count:total}=await db
.from("course_lessons")
.select("*",{count:"exact",head:true})
.eq("course_id",course_id);



const {count:completed}=await db
.from("learning_progress")
.select("*",{count:"exact",head:true})
.eq("user_id",user_id)
.eq("course_id",course_id)
.eq("completed",true);



if(!total || completed !== total){

return {

completed:false,

message:"Course not completed"

};

}



const {data:certificate,error}=await db
.from("certificates")
.upsert({

user_id,

course_id,

issued_at:new Date(),

status:"completed"

},
{
onConflict:"user_id,course_id"
})
.select()
.single();



if(error) throw error;



return {

completed:true,

certificate

};


}



module.exports={
checkAndCreateCertificate
};

JS



cat > api/certificate.js <<'JS'
const service=require("../services/certificate-service");


module.exports=async function(req,res){

try{


const result=
await service.checkAndCreateCertificate(
req.body.user_id,
req.body.course_id
);


res.json(result);


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "certificate" server.js
then

cat >> server.js <<'JS'


// Certificate API

const certificate=require("./api/certificate");

app.post(
"/api/certificate",
certificate
);

JS

fi



node -c server.js


echo ""
echo "✅ Certificate system created"

echo ""
echo "Flow:"
echo "Lesson complete"
echo "↓"
echo "100% progress"
echo "↓"
echo "Certificate generated"

