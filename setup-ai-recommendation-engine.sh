#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub AI Recommendation Engine Setup ==="

mkdir -p services/ai scripts


cat > services/ai/recommendation-engine.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const supabase=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);


async function generateRecommendations(){

 console.log("Starting AI matching...");


 const {data:learners,error:lerr}=await supabase
 .from("learner_skills")
 .select("*");


 if(lerr) throw lerr;


 const {data:jobs,error:jerr}=await supabase
 .from("external_opportunities")
 .select("*");


 if(jerr) throw jerr;


 let matches=[];


 for(const learner of learners){

   for(const job of jobs){

     let score=50;


     const skill=
       learner.skill?.toLowerCase() || "";


     const title=
       job.title?.toLowerCase() || "";


     if(title.includes(skill)){
        score=90;
     }


     if(score>=50){

       matches.push({

        user_id: learner.user_id,

        opportunity_id: job.id,

        match_score: score,

        reason:
        "AI matched using learner skill profile",

        status:"new"

       });

     }

   }

 }


 if(matches.length){

   const {error}=await supabase
   .from("recommendations")
   .insert(matches);


   if(error) throw error;

 }


 console.log(
 "AI Recommendations Created:",
 matches.length
 );


}


generateRecommendations()
.catch(err=>{
 console.error(err.message);
 process.exit(1);
});
JS



cat > scripts/run-ai-recommendation.js <<'JS'
require("../services/ai/recommendation-engine");
JS



cat > api/recommendations/run.js <<'JS'
const engine=require("../../services/ai/recommendation-engine");

module.exports=async function(req,res){

 try{

  await engine();

  res.json({
    success:true,
    message:"AI recommendation completed"
  });

 }catch(e){

  res.status(500).json({
   error:e.message
  });

 }

};
JS


echo ""
echo "Created:"
echo "services/ai/recommendation-engine.js"
echo "scripts/run-ai-recommendation.js"
echo "api/recommendations/run.js"

echo ""
echo "Testing syntax..."

node -c services/ai/recommendation-engine.js

echo ""
echo "=== AI Recommendation Engine Ready ==="

