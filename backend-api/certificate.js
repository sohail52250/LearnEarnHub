const service=require("../services/certificate-service");


module.exports=async function(req,res){

try{


const result=
await service.checkAndCreateCertificate(
req.body.user_id,
req.body.course_id
);


res.json(result);


}catch(e){

res.status(500).json({
error:e.message
});

}

};

