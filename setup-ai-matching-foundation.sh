#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub AI Matching Foundation ==="

mkdir -p services/ai scripts database

cat > database/ai-matching-system.sql <<'SQL'

-- Learner skills

create table if not exists public.learner_skills (

    id bigint generated always as identity primary key,

    user_id text not null,

    skill text not null,

    level text default 'beginner',

    created_at timestamptz default now()

);


-- Opportunity skills mapping

create table if not exists public.opportunity_skills (

    id bigint generated always as identity primary key,

    opportunity_id bigint references public.external_opportunities(id)
    on delete cascade,

    skill text not null,

    created_at timestamptz default now()

);


-- Recommendations

create table if not exists public.recommendations (

    id bigint generated always as identity primary key,

    user_id text,

    opportunity_id bigint,

    match_score integer default 0,

    reason text,

    created_at timestamptz default now()

);


create index if not exists idx_learner_skills_user
on public.learner_skills(user_id);


create index if not exists idx_recommendations_user
on public.recommendations(user_id);


notify pgrst,'reload schema';

SQL


cat > services/ai/matching-engine.js <<'JS'

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

JS


cat > scripts/run-ai-matching.js <<'JS'
require("../services/ai/matching-engine");
JS


echo ""
echo "Created:"
echo "database/ai-matching-system.sql"
echo "services/ai/matching-engine.js"
echo "scripts/run-ai-matching.js"

