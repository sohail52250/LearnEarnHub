const service=require("../services/profile-service");


module.exports=async function(req,res){

try{


if(req.query.user_id){

return res.json(
await service.getProfile(
req.query.user_id
)
);

}



if(req.body.action==="update"){

return res.json(
await service.updateProfile(
req.body.data
)
);

}



if(req.body.action==="review"){

return res.json(
await service.addReview(
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

