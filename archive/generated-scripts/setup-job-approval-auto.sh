#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Job Approval Workflow Setup ==="

mkdir -p services api public



cat > database/job-approval.sql <<'SQL'

CREATE TABLE IF NOT EXISTS job_submissions (

id BIGSERIAL PRIMARY KEY,

opportunity_id BIGINT REFERENCES business_opportunities(id) ON DELETE CASCADE,

learner_id UUID NOT NULL,

submission_text TEXT,

status TEXT DEFAULT 'submitted',

submitted_at TIMESTAMP DEFAULT NOW(),

approved_at TIMESTAMP DEFAULT NULL

);



CREATE INDEX IF NOT EXISTS job_submission_learner_idx

ON job_submissions(learner_id);


SQL



cat > services/job-approval-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_SERVICE_KEY ?
process.env.SUPABASE_URL : "",
process.env.SUPABASE_SERVICE_KEY
);



async function submitJob(data){


const {data:result,error}=await db
.from("job_submissions")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function approveJob(id){


const {data:submission,error}=await db
.from("job_submissions")
.update({

status:"approved",

approved_at:new Date()

})
.eq("id",id)
.select()
.single();



if(error) throw error;



return submission;

}



async function rejectJob(id){


const {data,error}=await db
.from("job_submissions")
.update({

status:"rejected"

})
.eq("id",id)
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

submitJob,

approveJob,

rejectJob

};

JS



cat > api/job-approval.js <<'JS'
const service=require("../services/job-approval-service");


module.exports=async function(req,res){

try{


if(req.body.action==="submit"){

return res.json(
await service.submitJob(
req.body.data
)
);

}



if(req.body.action==="approve"){

return res.json(
await service.approveJob(
req.body.id
)
);

}



if(req.body.action==="reject"){

return res.json(
await service.rejectJob(
req.body.id
)
);

}



res.status(400).json({
error:"Invalid action"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

JS



if ! grep -q "/api/job-approval" server.js
then

cat >> server.js <<'JS'


// Job Approval API

const jobApproval=require("./api/job-approval");


app.post(
"/api/job-approval",
jobApproval
);


JS

fi



cat > public/job-submit.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>Submit Completed Work</title>

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

textarea,input,button{

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


<h1>✅ Submit Completed Task</h1>


<input id="opportunity_id" placeholder="Opportunity ID">


<input id="learner_id" placeholder="Learner ID">


<textarea id="text" placeholder="Describe completed work"></textarea>


<button onclick="submitWork()">

Submit

</button>


<p id="msg"></p>


</div>



<script>


async function submitWork(){


let r=
await fetch(
"/api/job-approval",
{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

action:"submit",

data:{

opportunity_id:Number(opportunity_id.value),

learner_id:learner_id.value,

submission_text:text.value

}

})

});


let d=await r.json();


msg.innerText=
d.error || "Submitted ✅";


}


</script>


</body>

</html>
HTML



node -c server.js


echo ""
echo "✅ Job approval workflow created"

echo ""
echo "Flow:"
echo "Learner submits work"
echo " ↓"
echo "Business approves"
echo " ↓"
echo "Earnings can be released"


