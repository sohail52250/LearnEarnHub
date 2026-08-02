#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Auto Certificate Skill Trigger ==="

mkdir -p services api



cat > services/certificate-trigger-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function completeCertificateFlow(
user_id,
course_id,
certificate_id,
skill_name
){



// Create verified skill

const {data:skill,error}=await db
.from("learner_skills")
.upsert({

user_id,

course_id,

certificate_id,

skill_name,

verified:true

})
.select()
.single();



if(error) throw error;



// Unlock opportunities

const {error:oppError}=await db
.from("opportunity_access")
.upsert({

user_id,

skill_id:skill.id,

unlocked:true

});



if(oppError) throw oppError;



return {

success:true,

message:"Certificate verified. Skill unlocked. Opportunities available.",

skill

};


}



module.exports={
completeCertificateFlow
};

JS



cat > api/certificate-complete.js <<'JS'
const service=require("../services/certificate-trigger-service");


module.exports=async function(req,res){

try{


const result=
await service.completeCertificateFlow(

req.body.user_id,

req.body.course_id,

req.body.certificate_id,

req.body.skill_name

);



res.json(result);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/certificate-complete" server.js
then

cat >> server.js <<'JS'


// Certificate Completion Trigger

const certificateComplete=require("./api/certificate-complete");


app.post(
"/api/certificate-complete",
certificateComplete
);


JS

fi



node -c server.js


echo ""
echo "✅ Automatic certificate skill trigger created"

echo ""
echo "New flow:"
echo "Course Complete"
echo "      ↓"
echo "Certificate Generated"
echo "      ↓"
echo "Skill Verified"
echo "      ↓"
echo "Opportunities Unlocked"


