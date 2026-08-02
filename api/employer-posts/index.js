const service=require("../../services/employer-post-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createJob(
req.body.data
)
);

}



return res.json(
await service.listJobs()
);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

