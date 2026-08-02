#!/data/data/com.termux/files/usr/bin/bash

echo "=== Upgrading AI Skill Matcher ==="

cat > services/ai/job-matching-bridge.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);


async function matchJobs(){

console.log("AI Skill Matching Started");


const {data:learners,error:lerr}=await db
.from("learner_skills")
.select("*");


if(lerr) throw lerr;



const {data:skills,error:serr}=await db
.from("job_skills")
.select("*");


if(serr) throw serr;



let results=[];



for(const learner of learners || []){


for(const skill of skills || []){


let score=0;


const learnerSkill=
(learner.skill || "")
.toLowerCase();


const jobSkill=
(skill.skill || "")
.toLowerCase();



if(learnerSkill === jobSkill){

score=95;

}
else if(
jobSkill.includes(learnerSkill) ||
learnerSkill.includes(jobSkill)
){

score=75;

}



if(score>0){


results.push({

user_id: learner.user_id,

opportunity_id:
skill.opportunity_id,

match_score:score,

confidence:
score>=90
?"Excellent Match"
:
"Good Match",

reason:
"AI skill similarity match",

status:"new"

});


}


}

}



if(results.length){


await db
.from("recommendations")
.upsert(
results,
{
onConflict:
"user_id,opportunity_id"
}
);


}



console.log(
"Matches Generated:",
results.length
);


}


matchJobs()
.catch(e=>{
console.error(e.message);
process.exit(1);
});

JS



node -c services/ai/job-matching-bridge.js

echo "=== AI Skill Matcher Updated ==="

