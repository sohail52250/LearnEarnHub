#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Job Sync Scheduler Setup ==="

mkdir -p services/jobs scripts logs



cat > services/jobs/job-sync-service.js <<'JS'
require("dotenv").config();

const importer=require("../job-importer");


const Adzuna=require("../job-connectors/adzuna");
const Jooble=require("../job-connectors/jooble");
const Remote=require("../job-connectors/remote");



async function syncSource(connector,source_id){


const jobs=
await connector.fetchJobs();



const normalized=
jobs.map(
j=>connector.normalize(j)
);



return await importer.importJobs(
normalized,
source_id
);


}



async function runSync(){


let results=[];



try{


results.push(
await syncSource(
new Adzuna(),
1
)
);



results.push(
await syncSource(
new Jooble(),
2
)
);



results.push(
await syncSource(
new Remote(),
3
)
);



console.log(
"✅ Job sync completed",
results.length
);



}catch(e){


console.log(
"❌ Sync error:",
e.message
);


}



}



module.exports={
runSync
};


JS



cat > scripts/job-sync-runner.js <<'JS'
const sync=require("../services/jobs/job-sync-service");


sync.runSync()
.then(()=>{

console.log("Finished");

process.exit();

})
.catch(e=>{

console.error(e);

process.exit(1);

});

JS



cat > scripts/job-sync.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash


DATE=$(date)


echo "=== LearnEarnHub Job Sync $DATE ===" >> logs/job-sync.log


node scripts/job-sync-runner.js >> logs/job-sync.log 2>&1


echo "============================" >> logs/job-sync.log

SH



chmod +x scripts/job-sync.sh



cat > scripts/setup-cron-job.sh <<'SH'
#!/data/data/com.termux/files/usr/bin/bash


echo "Install Termux cron support:"


echo ""

echo "pkg install cronie"


echo ""

echo "Then add:"


echo "0 * * * * cd ~/EarnTask/LearnEarnHub && ./scripts/job-sync.sh"


echo ""

echo "This runs every hour."

SH



chmod +x scripts/setup-cron-job.sh



node -c server.js



echo ""

echo "✅ Job Sync Scheduler Created"

echo ""

echo "Features:"

echo "⏰ Hourly sync ready"

echo "🌍 Multiple API connectors"

echo "📥 Automatic job import"

echo "📝 Sync logs"


