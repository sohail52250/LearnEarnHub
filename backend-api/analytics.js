const service=require("../services/analytics-service");


module.exports=async function(req,res){

try{


if(req.query.action==="stats"){

return res.json(
await service.dashboardStats()
);

}



if(req.query.action==="categories"){

return res.json(
await service.categoryReport()
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

