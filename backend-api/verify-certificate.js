const service=require("../services/certificate-verification-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createVerification(
req.body.data
)
);

}



if(req.query.code){

return res.json(
await service.verify(
req.query.code
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

