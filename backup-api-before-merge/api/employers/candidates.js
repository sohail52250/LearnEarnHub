const service=require("../../services/employer-search-service");


module.exports=async function(req,res){

try{


if(req.body.action==="view"){

return res.json(
await service.viewCandidate(
req.body.data
)
);

}



return res.json(
await service.searchCandidates(
req.query.skill
)
);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

