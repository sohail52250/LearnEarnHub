const service=require("../services/auth-service");


module.exports=async function(req,res){

try{


if(req.body.action==="signup"){


return res.json(
await service.signup(
req.body.email,
req.body.password
)
);


}



if(req.body.action==="login"){


return res.json(
await service.login(
req.body.email,
req.body.password
)
);


}



res.status(400).json({
error:"Invalid action"
});



}catch(e){

res.status(500).json({
error:e.message
});

}


};

