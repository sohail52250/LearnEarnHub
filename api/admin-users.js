const service=require("../services/user-role-service");


module.exports=async function(req,res){

try{


if(req.query.action==="users"){

return res.json(
await service.getUsers()
);

}



if(req.query.action==="role"){

return res.json(
await service.getRole(
req.query.user_id
)
);

}



if(req.body.action==="update-role"){

return res.json(
await service.updateRole(
req.body.user_id,
req.body.role
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

