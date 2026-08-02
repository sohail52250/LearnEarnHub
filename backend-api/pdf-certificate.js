const service=require("../services/pdf-certificate-service");


module.exports=async function(req,res){

try{


const result=
await service.generateCertificate(
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

