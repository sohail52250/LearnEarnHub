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


