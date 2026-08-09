require("dotenv").config();

const axios=require("axios");

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function syncJobs(){


console.log("=== Job API Sync Started ===");


// Demo connector foundation
// Add external API keys later

const jobs=[

{
external_id:"LEH-AUTO-001",
title:"AI Assistant Remote Work",
company:"LearnEarnHub AI Partner",
description:"Remote AI and digital assistant opportunity",
location:"Remote",
category:"Technology",
opportunity_type:"Remote Work",
status:"active"
},

{
external_id:"LEH-AUTO-002",
title:"Content Writing Opportunity",
company:"LearnEarnHub Partner",
description:"Freelance writing and content creation",
location:"Remote",
category:"Writing",
opportunity_type:"Freelance",
status:"active"
}

];



for(const job of jobs){


await db

.from("imported_jobs")

.upsert(

job,

{
onConflict:"external_id"
}

);


console.log(
"Synced:",
job.title
);


}



console.log("=== Sync Complete ===");


}



syncJobs()
.catch(e=>{

console.error(e.message);

process.exit(1);

});
