const service=require("../services/job-approval-service");


module.exports=async function(req,res){

try{


if(req.body.action==="submit"){

return res.json(
await service.submitJob(
req.body.data
)
);

}



if(req.body.action==="approve"){

return res.json(
await service.approveJob(
req.body.id
)
);

}



if(req.body.action==="reject"){

return res.json(
await service.rejectJob(
req.body.id
)
);

}



res.status(400).json({
error:"Invalid action"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

