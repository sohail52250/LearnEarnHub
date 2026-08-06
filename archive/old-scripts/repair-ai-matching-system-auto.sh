#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub AI Matching Repair ==="


echo ""
echo "=== Creating SQL Repair File ==="


cat > database/repair-ai-matching.sql <<'SQL'

-- =========================================
-- AI Matching Cleanup & Repair
-- =========================================


-- Remove old weak matches

delete from public.recommendations;


-- Ensure job skills table exists

create table if not exists public.job_skills (

id bigint generated always as identity primary key,

opportunity_id bigint
references public.imported_jobs(id)
on delete cascade,

skill text not null,

created_at timestamptz default now(),

unique(opportunity_id,skill)

);



-- Ensure AI matching fields

alter table public.recommendations
add column if not exists confidence text;



-- Add skills automatically from job data

insert into public.job_skills
(opportunity_id,skill)

select
id,
'AI'

from public.imported_jobs

where lower(title) like '%ai%'

on conflict do nothing;



insert into public.job_skills
(opportunity_id,skill)

select
id,
'Writing'

from public.imported_jobs

where lower(title) like '%writer%'

on conflict do nothing;



insert into public.job_skills
(opportunity_id,skill)

select
id,
'Data Entry'

from public.imported_jobs

where lower(title) like '%data%'

on conflict do nothing;



notify pgrst,'reload schema';

SQL



echo ""
echo "SQL CREATED:"
echo "database/repair-ai-matching.sql"


echo ""
echo "=== Checking Current Skills ==="


node - <<'JS'

require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


(async()=>{

let a=await db
.from("learner_skills")
.select("*");

console.log("Learner Skills:");
console.log(a.data);


let b=await db
.from("job_skills")
.select("*");

console.log("Job Skills:");
console.log(b.data);


})();

JS



echo ""
echo "=== Repair Ready ==="
echo "Run SQL in Supabase:"
echo "database/repair-ai-matching.sql"
echo ""
echo "Then run:"
echo "node scripts/run-ai-job-matching.js"

