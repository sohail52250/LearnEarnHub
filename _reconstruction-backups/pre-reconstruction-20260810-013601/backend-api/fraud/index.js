const service=require("../../services/fraud-service");


module.exports=async function(req,res){

try{


res.json(
await service.createFlag(
req.body
)
);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

