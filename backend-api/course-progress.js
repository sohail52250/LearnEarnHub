const service=require("../services/course-progress-service");


module.exports=async function(req,res){

try{


const action=req.body.action;


if(action==="enroll"){

return res.json(
await service.enrollCourse(
req.body.user_id,
req.body.course_id
));

}



if(action==="complete"){

return res.json(
await service.completeLesson(
req.body.user_id,
req.body.course_id,
req.body.lesson_id
));

}



if(action==="progress"){

return res.json(
await service.getProgress(
req.body.user_id,
req.body.course_id
));

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

