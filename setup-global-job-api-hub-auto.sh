#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Global Job API Hub Setup ==="

mkdir -p services/job-connectors scripts database


cat > database/job-api-hub.sql <<'SQL'

-- External source registry

create table if not exists public.job_sources (

 id bigint generated always as identity primary key,

 name text not null,

 api_url text,

 source_type text default 'api',

 status text default 'active',

 created_at timestamptz default now()

);


-- Imported jobs cache

create table if not exists public.imported_jobs (

 id bigint generated always as identity primary key,

 source_id bigint references public.job_sources(id),

 external_id text,

 title text,

 company text,

 description text,

 location text,

 category text,

 job_url text,

 imported_at timestamptz default now(),

 status text default 'active',

 unique(source_id,external_id)

);


create index if not exists idx_imported_jobs_title
on public.imported_jobs(title);


create index if not exists idx_imported_jobs_source
on public.imported_jobs(source_id);


-- Insert supported source examples

insert into public.job_sources
(name,api_url,source_type)
values

('Adzuna','https://api.adzuna.com','API'),

('Jooble','https://jooble.org/api','API'),

('Remote Jobs','https://remoteok.com/api','API'),

('LinkedIn Partner Feed','partner-api','PARTNER')

on conflict do nothing;


notify pgrst,'reload schema';

SQL



cat > services/job-connectors/global-job-sync.js <<'JS'

require("dotenv").config();

const axios=require("axios");

const {createClient}=require("@supabase/supabase-js");


const supabase=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);



async function syncJobs(){


console.log("Global job sync started");


const {data:sources}=await supabase
.from("job_sources")
.select("*")
.eq("status","active");


for(const source of sources || []){


console.log(
"Checking:",
source.name
);


// Placeholder connector layer
// API keys can be added safely later


const sample={

source_id:source.id,

external_id:
`${source.name}-demo-001`,

title:
"Remote AI Assistant",

company:
"Global Employer",

description:
"AI, research and digital tasks",

location:
"Remote",

category:
"Technology",

job_url:
source.api_url

};



await supabase
.from("imported_jobs")
.upsert(
sample,
{
onConflict:
"source_id,external_id"
});


}


console.log("Global job sync completed");

}


syncJobs()
.catch(e=>{
console.error(e.message);
process.exit(1);
});

JS



cat > scripts/run-global-job-sync.js <<'JS'
require("../services/job-connectors/global-job-sync");
JS



echo ""
echo "Created:"
echo "database/job-api-hub.sql"
echo "services/job-connectors/global-job-sync.js"
echo "scripts/run-global-job-sync.js"


node -c services/job-connectors/global-job-sync.js


echo ""
echo "=== Global Job API Hub Ready ==="

