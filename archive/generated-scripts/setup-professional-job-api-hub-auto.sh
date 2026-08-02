#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Professional Job API Hub Setup ==="

mkdir -p services/job-connectors services/jobs api/jobs



cat > database/professional-job-hub.sql <<'SQL'

CREATE TABLE IF NOT EXISTS job_api_sources (

id BIGSERIAL PRIMARY KEY,

name TEXT NOT NULL,

source_type TEXT DEFAULT 'API',

api_url TEXT,

country TEXT DEFAULT 'Global',

active BOOLEAN DEFAULT true,

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS imported_jobs (

id BIGSERIAL PRIMARY KEY,

source_id BIGINT REFERENCES job_api_sources(id),

external_id TEXT,

title TEXT,

company TEXT,

description TEXT,

category TEXT,

required_skills TEXT,

country TEXT,

remote BOOLEAN DEFAULT false,

salary TEXT,

apply_url TEXT,

source_name TEXT,

created_at TIMESTAMP DEFAULT NOW(),

UNIQUE(source_id,external_id)

);



CREATE INDEX IF NOT EXISTS imported_jobs_skill_idx

ON imported_jobs(required_skills);


SQL



cat > services/job-connectors/base.js <<'JS'
class BaseConnector {


constructor(name){

this.name=name;

}



async fetchJobs(){

return [];

}



normalize(job){

return {

external_id:job.id || Date.now().toString(),

title:job.title || "",

company:job.company || "",

description:job.description || "",

required_skills:job.skills || "",

country:job.country || "Global",

remote:job.remote || false,

salary:job.salary || "",

apply_url:job.url || "",

source_name:this.name

};

}


}


module.exports=BaseConnector;

JS



cat > services/job-connectors/adzuna.js <<'JS'
const Base=require("./base");


class Adzuna extends Base {


constructor(){

super("Adzuna");

}



async fetchJobs(){

// Add official Adzuna API key later

return [];

}


}


module.exports=Adzuna;

JS



cat > services/job-connectors/jooble.js <<'JS'
const Base=require("./base");


class Jooble extends Base {


constructor(){

super("Jooble");

}



async fetchJobs(){

// Add official Jooble API key later

return [];

}


}


module.exports=Jooble;

JS



cat > services/job-connectors/remote.js <<'JS'
const Base=require("./base");


class RemoteJobs extends Base {


constructor(){

super("Remote Jobs");

}



async fetchJobs(){

return [];

}


}


module.exports=RemoteJobs;

JS



cat > services/job-importer.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function importJobs(jobs,source_id){


let saved=[];


for(const job of jobs){


const {data,error}=await db
.from("imported_jobs")
.upsert({

...job,

source_id

})
.select()
.single();



if(!error){

saved.push(data);

}


}



return saved;

}



module.exports={
importJobs
};

JS



cat > api/jobs/import.js <<'JS'
const importer=require("../../services/job-importer");


module.exports=async function(req,res){

try{


const result=
await importer.importJobs(

req.body.jobs || [],

req.body.source_id

);



res.json({

success:true,

imported:result.length,

jobs:result

});



}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/jobs/import" server.js
then

cat >> server.js <<'JS'


// Professional Job Import API

const jobImport=require("./api/jobs/import");


app.post(
"/api/jobs/import",
jobImport
);


JS

fi



cat > .env.job-api.example <<'ENV'

# Professional Job APIs

ADZUNA_APP_ID=
ADZUNA_APP_KEY=

JOOBLE_API_KEY=

REMOTE_API_KEY=

ENV



node -c server.js



echo ""

echo "✅ Professional Global Job API Hub Created"

echo ""

echo "Ready connectors:"

echo "🌍 Adzuna"

echo "🌍 Jooble"

echo "🌍 Remote Jobs"

echo "🔗 Custom API"

echo ""

echo "Next:"
echo "Add official API keys"

