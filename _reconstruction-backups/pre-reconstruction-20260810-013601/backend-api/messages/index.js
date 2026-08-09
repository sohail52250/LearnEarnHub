const service=require("../../services/message-service");


module.exports=async function(req,res){

try{


if(req.body.action==="send"){

return res.json(
await service.sendMessage(
req.body.data
)
);

}



if(req.query.user_id){

return res.json(
await service.inbox(
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

