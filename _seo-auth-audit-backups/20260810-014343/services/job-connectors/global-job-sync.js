
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

