const service=require("../services/certificate-trigger-service");


module.exports=async function(req,res){

try{


const result=
await service.completeCertificateFlow(

req.body.user_id,

req.body.course_id,

req.body.certificate_id,

req.body.skill_name

);



res.json(result);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

