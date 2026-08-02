const service=require("../services/ranking-service");


module.exports=async function(req,res){

try{


if(req.body.action==="update"){

return res.json(
await service.updateScore(
req.body.user_id,
req.body.points
)
);

}



return res.json(
await service.getRanking()
);



}catch(e){

res.status(500).json({
error:e.message
});

}

};

