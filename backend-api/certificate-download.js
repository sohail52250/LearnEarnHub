const service=require("../services/certificate-download-service");


module.exports=async function(req,res){

try{


if(req.body.action==="create"){

return res.json(
await service.createCertificate(
req.body.user_id,
req.body.course_id
)
);

}



if(req.query.user_id){

return res.json(
await service.getCertificate(
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

