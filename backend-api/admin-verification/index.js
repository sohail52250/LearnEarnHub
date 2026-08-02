const service=require("../../services/admin-verification-service");


module.exports=async function(req,res){

try{


if(req.body.action==="update"){

return res.json(
await service.updateStatus(
req.body.id,
req.body.status
)
);

}



return res.json(
await service.pendingRecords()
);



}catch(e){

res.status(500).json({

error:e.message

});

}

};

