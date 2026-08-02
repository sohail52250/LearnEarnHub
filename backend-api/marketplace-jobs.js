const service=require("../services/marketplace-service");


module.exports=async function(req,res){

try{


if(req.query.user_id){

return res.json(
await service.getAvailableJobs(
req.query.user_id
)
);

}



if(req.body.action==="apply"){

return res.json(
await service.applyJob(
req.body.user_id,
req.body.opportunity_id
)
);

}



res.status(400).json({
error:"Invalid request"
});



}catch(e){

res.status(500).json({
error:e.message
});

}

};

