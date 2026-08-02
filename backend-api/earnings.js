const service=require("../services/earning-service");


module.exports=async function(req,res){

try{


if(req.body.action==="add"){

return res.json(
await service.addEarning(
req.body.data
)
);

}



if(req.query.learner_id){

return res.json({

records:
await service.getEarnings(
req.query.learner_id
),

total:
await service.totalEarned(
req.query.learner_id
)

});

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

