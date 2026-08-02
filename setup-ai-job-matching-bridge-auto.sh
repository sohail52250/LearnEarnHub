#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub AI Job Matching Bridge ==="


mkdir -p services/ai scripts



cat > services/ai/job-matching-bridge.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);



async function matchJobs(){


console.log("AI job matching started");


const {data:learners,error:lerr}=await db
.from("learner_skills")
.select("*");


if(lerr) throw lerr;



const {data:jobs,error:jerr}=await db
.from("imported_jobs")
.select("*")
.eq("status","active");


if(jerr) throw jerr;



let recommendations=[];



for(const learner of learners || []){


for(const job of jobs || []){


let score=0;


const learnerSkill=
learner.skill.toLowerCase();



const jobSkills=
(job.skills || [])
.map(x=>x.toLowerCase());



if(jobSkills.includes(learnerSkill))
{
score=95;
}
else
{
const text=
`${job.title} ${job.description}`
.toLowerCase();


if(text.includes(learnerSkill))
score=75;

}



if(score>=70){


recommendations.push({

user_id: learner.user_id,

opportunity_id: job.id,

match_score:score,

reason:
"AI matched job with learner skill",

status:"new"


});


}


}

}



if(recommendations.length){


await db
.from("recommendations")
.insert(recommendations);


}



console.log(
"Recommendations created:",
recommendations.length
);


}



matchJobs()
.catch(e=>{
console.error(e.message);
process.exit(1);
});

JS



cat > scripts/run-ai-job-matching.js <<'JS'
require("../services/ai/job-matching-bridge");
JS



node -c services/ai/job-matching-bridge.js


echo ""
echo "Created:"
echo "services/ai/job-matching-bridge.js"
echo "scripts/run-ai-job-matching.js"

echo ""
echo "=== AI Matching Bridge Ready ==="

