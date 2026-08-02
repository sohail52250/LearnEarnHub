const service=require("../services/notification-service");


module.exports=async function(req,res){

try{


if(req.body && (req.body?.action)==="send"){

return res.json(
await service.sendNotification(
req.body.data
)
);

}



if(req.body && (req.body?.action)==="read"){

return res.json(
await service.markRead(
req.body.id
)
);

}



if(req.query.user_id){

return res.json(
await service.getNotifications(
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

