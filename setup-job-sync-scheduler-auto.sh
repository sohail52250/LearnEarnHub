#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Job Sync Scheduler Setup ==="


mkdir -p services/job-sync scripts



cat > services/job-sync/auto-job-sync.js <<'JS'
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
JS



cat > scripts/run-job-sync.js <<'JS'
require("../services/job-sync/auto-job-sync");
JS



cat > scripts/job-sync-cron.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

node scripts/run-job-sync.js

node scripts/run-ai-job-matching.js

node scripts/run-ai-alert-engine.js

echo "AI Job Cycle Completed"
SH



chmod +x scripts/job-sync-cron.sh



node -c services/job-sync/auto-job-sync.js


echo ""
echo "Created:"
echo "services/job-sync/auto-job-sync.js"
echo "scripts/run-job-sync.js"
echo "scripts/job-sync-cron.sh"

echo ""
echo "=== Scheduler Ready ==="

