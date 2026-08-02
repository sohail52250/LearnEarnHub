const service=require("../services/employer-service");


module.exports=async function(req,res){

try{


if(req.body.action==="post"){

return res.json(
await service.createOpportunity(
req.body.data
)
);

}



if(req.body.action==="hire"){

return res.json(
await service.hireLearner(
req.body.opportunity_id,
req.body.learner_id
)
);

}



return res.json(
await service.listOpportunities()
);



}catch(e){

res.status(500).json({
error:e.message
});

}

};

