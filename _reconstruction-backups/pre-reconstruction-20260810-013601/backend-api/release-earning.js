const service=require("../services/auto-earn-release-service");


module.exports=async function(req,res){

try{


const result=
await service.approveAndRelease(

req.body.submission_id,

req.body.amount,

req.body.currency

);



res.json(result);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

