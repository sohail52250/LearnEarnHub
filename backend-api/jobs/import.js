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

