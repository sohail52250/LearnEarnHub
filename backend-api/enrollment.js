const service=require("../services/enrollment-service");


module.exports=async function(req,res){

try{


if(req.body.action==="enroll"){


return res.json(
await service.enroll(
req.body.user_id,
req.body.course_id
)
);


}



if(req.body.action==="list"){


return res.json(
await service.myCourses(
req.body.user_id
)
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

