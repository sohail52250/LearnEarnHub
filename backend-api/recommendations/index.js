const service=require("../../services/recommendation-service");


module.exports=async function(req,res){

try{


if(req.body.action==="generate"){

return res.json(
await service.generate(
req.body.user_id
)
);

}



if(req.query.user_id){

return res.json(
await service.get(
req.query.user_id
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

