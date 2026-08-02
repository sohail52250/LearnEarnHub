const service=require("../services/skill-unlock-service");


module.exports=async function(req,res){

try{


if(req.body.action==="unlock"){

return res.json(
await service.unlockSkill(
req.body.user_id,
req.body.course_id,
req.body.certificate_id,
req.body.skill_name
)
);

}



if(req.query.user_id){

return res.json(
await service.getSkills(
req.query.user_id
)
);

}



res.status(400).json({
error:"Invalid request"
});


}catch(e){

res.status(500).json({
error:e.message
});

}

};

