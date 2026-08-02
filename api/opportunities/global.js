const service=require("../../services/opportunity-service");


module.exports=async function(req,res){

try{


if(req.body && req.body.action==="add"){

return res.json(
await service.addOpportunity(
req.body.data
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

