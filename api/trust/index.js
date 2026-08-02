const service=require("../../services/trust-service");


module.exports=async function(req,res){

try{


if(req.body.action==="verify"){

return res.json(
await service.createVerification(
req.body.data
)
);

}



if(req.body.action==="score"){

return res.json(
await service.updateReputation(
req.body.user_id,
req.body.data
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

