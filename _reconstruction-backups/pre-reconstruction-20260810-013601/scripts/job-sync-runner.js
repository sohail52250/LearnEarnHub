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

