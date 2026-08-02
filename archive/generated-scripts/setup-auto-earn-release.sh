#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Auto Earnings Release Setup ==="

mkdir -p services api



cat > services/auto-earn-release-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function approveAndRelease(
submission_id,
amount,
currency="USD"
){



// approve submission

const {data:job,error}=await db
.from("job_submissions")
.update({

status:"approved",

approved_at:new Date()

})
.eq("id",submission_id)
.select()
.single();



if(error) throw error;



// create earning record

const {data:earning,error:earnError}=await db
.from("learner_earnings")
.insert({

learner_id:job.learner_id,

opportunity_id:job.opportunity_id,

amount,

currency,

status:"released",

paid_at:new Date()

})
.select()
.single();



if(earnError) throw earnError;



return {

success:true,

message:"Job approved and earning released",

earning

};


}



module.exports={
approveAndRelease
};

JS



cat > api/release-earning.js <<'JS'
const service=require("../services/auto-earn-release-service");


module.exports=async function(req,res){

try{


const result=
await service.approveAndRelease(

req.body.submission_id,

req.body.amount,

req.body.currency

);



res.json(result);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/release-earning" server.js
then

cat >> server.js <<'JS'


// Automatic Earning Release API

const releaseEarning=require("./api/release-earning");


app.post(
"/api/release-earning",
releaseEarning
);


JS

fi



node -c server.js


echo ""
echo "✅ Auto earning release system created"

echo ""
echo "Complete flow:"
echo "Course"
echo " ↓"
echo "Certificate"
echo " ↓"
echo "Verified Skill"
echo " ↓"
echo "Job"
echo " ↓"
echo "Submission"
echo " ↓"
echo "Approval"
echo " ↓"
echo "Earning Released"


