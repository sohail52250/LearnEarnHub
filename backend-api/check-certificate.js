const {generateCertificate}=require("../services/certificate-generator");


module.exports=async function(req,res){

try{

const result=await generateCertificate(
req.body.user_id,
req.body.course_id
);


res.json({

certificate:result

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

