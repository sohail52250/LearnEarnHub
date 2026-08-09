
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);


async function runMatching(){

 const {data:users}=await db
 .from("learner_skills")
 .select("*");


 const {data:jobs}=await db
 .from("external_opportunities")
 .select("*");


 if(!users || !jobs){
   console.log("No data");
   return;
 }


 let results=[];


 users.forEach(user=>{

   jobs.forEach(job=>{

      let score=50;

      results.push({

       user_id:user.user_id,

       opportunity_id:job.id,

       match_score:score,

       reason:
       "Matched using learner skill profile"

      });

   });

 });


 if(results.length){

 await db
 .from("recommendations")
 .insert(results);

 }


 console.log(
 "Recommendations created:",
 results.length
 );

}


runMatching();

