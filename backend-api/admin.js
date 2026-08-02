const service=require("../services/admin-service");


module.exports=async function(req,res){

try{


if(req.query.action==="stats"){

return res.json(
await service.stats()
);

}



if(req.query.action==="courses"){

return res.json(
await service.courses()
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

